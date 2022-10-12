#!/usr/bin/env ruby

require 'benchmark'
require 'json'
require 'net/http'
require 'pathname'
require 'time'

class Loader
  attr_reader :scenario
  attr_reader :mutex
  attr_reader :results

  def initialize(path)
    abort "シナリオのパスを指定してください。" unless path
    scenario_path = Pathname.new(path)
    abort "パスが見つかりません: #{scenario_path}" unless scenario_path.exist?
    @scenario = JSON.parse(scenario_path.read)
    @mutex = Thread::Mutex.new
    @results = []
  end

  def run
    info_log("試験を開始します。")
    threads = scenario["users"].times.map do |i|
      Thread.new(i) do |index|
        vu = VirtualUser.new(index)

        scenario["requests"].each do |req|
          r = case req["method"]
              when "GET"
                vu.get(req["url"])
              when "POST"
                vu.post(req["url"], req["body"])
              end
          # レスポンスタイム、リクエスト時間を保存
          mutex.lock
          results << r
          mutex.unlock
        end
      end
    end
    threads.each(&:join)
    analyze
    info_log("試験を終了します。")
  end

  private

  def info_log(msg)
    now = Time.now.strftime("%Y-%m-%d %H:%M:%S.%L")
    puts "#{now} [LOADER] #{msg}"
  end

  def analyze
    total_requests = 0
    total_response = 0
    rps = {}
    response_max = nil
    response_min = nil

    results.each do |r|
      rps[r[:time]] ||= 0
      rps[r[:time]] += 1

      # 最大レスポンスタイムを探す
      if !response_max || response_max < r[:response]
        response_max = r[:response]
      end

      # 最小レスポンスタイムを探す
      if !response_min || response_min > r[:response]
        response_min = r[:response]
      end

      # 平均レスポンスタイム計算用にリクエスト回数とレスポンスタイム合計を集計
      total_requests += 1
      total_response += r[:response]
    end

    response_avg = (total_response / total_requests).round(3)
    rps_max = rps.values.max
    rps_avg = (rps.values.sum / rps.size.to_f).round(2)

    info_log("")
    info_log("結果")
    info_log("---------------------------------------")
    info_log("リクエスト回数      : #{total_requests}")
    info_log("最大秒間リクエスト  : #{rps_max} req/秒")
    info_log("平均秒間リクエスト  : #{rps_avg} req/秒")
    info_log("最大レスポンスタイム: #{response_max} ms")
    info_log("最小レスポンスタイム: #{response_min} ms")
    info_log("平均レスポンスタイム: #{response_avg} ms")
    info_log("---------------------------------------")
  end

  class VirtualUser
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def get(url)
      request(Net::HTTP::Get, url, nil)
    end

    def post(url, params)
      request(Net::HTTP::Post, url, params)
    end

    def request(method_class, url, params = nil, headers = nil)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)

      if uri.scheme == 'https'
        http.use_ssl = true
      end

      req = nil
      method = nil
      if method_class == Net::HTTP::Get
        method = "GET"
        if params
          uri.query = URI.encode_www_form(params)
        end
        req = method_class.new(uri)
      else
        method = "POST"
        req = method_class.new(uri)
        if params
          req.form_data = params
        end
      end

      headers&.each do |key, value|
        req[key] = value
      end

      request_time = Time.now.to_i
      code = nil
      res = nil
      t = Benchmark.realtime do
        res = http.request(req)
        code = res.code
      end
      ms = (t * 1000).round(3)
      info_log("#{method}: #{url} (#{code}, #{ms}ms)")

      # 集計用に結果を返す
      { time: request_time, response: ms }
    end

    private

    def info_log(msg)
      now = Time.now.strftime("%Y-%m-%d %H:%M:%S.%L")
      puts "#{now} [LOADER][#{id}] #{msg}"
    end
  end

end

Loader.new(ARGV.shift).run
