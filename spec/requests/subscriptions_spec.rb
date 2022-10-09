require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do

  before(:each) do
    @subscription = FactoryBot.create(:subscription)
    @subscription1 = FactoryBot.create(:subscription, user_id: @subscription.user_id)
    @subscription2 = FactoryBot.create(:subscription, user_id: @subscription.user_id)
  end

  describe "GET /subscriptions" do
    context "成功" do
      it "指定したsubscription_idのサブスクデータが取得できる" do
        get "/subscriptions?userId=#{@subscription.user_id}"
        expect(response).to have_http_status :ok
        res = JSON.parse(response.body)
        expect(res['data']['subscriptions'][0]['name']).to eq(@subscription[:name])
        expect(res['data']['subscriptions'][0]['price']).to eq(@subscription[:price])
        expect(res['data']['subscriptions'][0]['paymentCycle']).to eq(@subscription[:payment_cycle])
        expect(res['data']['subscriptions'][0]['firstPaymentDate']).to eq(@subscription[:first_payment_date].strftime("%Y-%m-%d"))
        expect(res['data']['subscriptions'][0]['paymentMethod']).to eq(@subscription[:payment_method])
        expect(res['data']['subscriptions'][0]['remarks']).to eq(@subscription[:remarks])
        expect(res['data']['subscriptions'][0]['imageUrl']).to eq(@subscription[:image_url])
        expect(res['data']['subscriptions'][0]['isPaused']).to eq(@subscription[:is_paused])
        expect(res['data']['subscriptions'][1]['name']).to eq(@subscription1[:name])
        expect(res['data']['subscriptions'][2]['name']).to eq(@subscription2[:name])
      end
    end
  end

  describe "POST /subscription" do
    context "成功" do
      it "受け取ったResponseからサブスクを作成することができる" do
        body = {
          userId: @subscription.user_id,
          subscription: {
            name: "Amazon prime",
            price: 1000,
            paymentCycle: "oneMonth",
            firstPaymentDate: "2022-10-15",
            paymentMethod: "cash",
            remarks: "string",
            isPaused: false
          }
        }
        post "/subscriptions", params: body
        expect(response).to have_http_status :ok
        res = JSON.parse(response.body)
        expect(res['data']['subscription']['name']).to eq(body[:subscription][:name])
        expect(res['data']['subscription']['price']).to eq(body[:subscription][:price])
        expect(res['data']['subscription']['paymentCycle']).to eq(body[:subscription][:paymentCycle])
        expect(res['data']['subscription']['paymentMethod']).to eq(body[:subscription][:paymentMethod])
        expect(res['data']['subscription']['firstPaymentDate']).to eq(body[:subscription][:firstPaymentDate])
        expect(res['data']['subscription']['remarks']).to eq(body[:subscription][:remarks])
        expect(res['data']['subscription']['isPaused']).to eq(body[:subscription][:isPaused])
      end

      it "imageUrlが正しくない時imageUrlをnullにする" do
        body = {
          userId: @subscription.user_id,
          subscription: {
            name: "Amazon prime",
            price: 1000,
            paymentCycle: "oneMonth",
            firstPaymentDate: "2022-10-15",
            paymentMethod: "cash",
            imageUrl: "unknown_URL",
            remarks: "string",
            isPaused: false
          }
        }
        post "/subscriptions", params: body
        expect(response).to have_http_status(200)
        res = JSON.parse(response.body)
        expect(res['data']['subscription']['imageUrl']).to eq(nil)
      end
    end

    context "失敗" do
      it "ユーザーIDが登録されていない時エラーを吐く" do
        body = {
          userId: "unknown_user",
          subscription: {
            name: "Amazon prime",
            price: 1000,
            paymentCycle: "oneMonth",
            firstPaymentDate: "2022-10-15",
            paymentMethod: "cash",
            remarks: "string",
            isPaused: false
          }
        }
        post "/subscriptions", params: body
        expect(response).to have_http_status(404)
        res = JSON.parse(response.body)
        expect(res['errors']['field']).to eq("user_id")
        expect(res['errors']['message']).to eq("ユーザーIDが登録されていません。")
      end

      it "imageのフォーマットが正しくない時にエラーを吐く" do
        body = {
          userId: @subscription.user_id,
          subscription: {
            name: "Amazon prime",
            price: 1000,
            paymentCycle: "oneMonth",
            firstPaymentDate: "2022-10-15",
            paymentMethod: "cash",
            image: "unknown_image",
            remarks: "string",
            isPaused: false
          }
        }
        post "/subscriptions", params: body
        expect(response).to have_http_status(404)
        res = JSON.parse(response.body)
        expect(res['data']['subscription']['imageUrl']).to eq(nil)
        expect(res['errors']['field']).to eq("image")
        expect(res['errors']['message']).to eq("画像の保存に失敗しました。")
      end
    end
  end

  describe "POST /subscription/:id" do
    context "成功" do
      it "受け取ったResponseからサブスクを更新することができる" do
        body = {
          userId: @subscription.user_id,
          subscription: {
            name: "Amazon prime",
            price: 1000,
            paymentCycle: "oneMonth",
            firstPaymentDate: "2022-10-15",
            paymentMethod: "cash",
            remarks: "string",
            isPaused: false
          }
        }
        post "/subscriptions/#{@subscription.id}", params: body
        expect(response).to have_http_status :ok
        res = JSON.parse(response.body)
        puts res
        expect(res['data']['subscription']['name']).to eq(body[:subscription][:name])
        expect(res['data']['subscription']['price']).to eq(body[:subscription][:price])
        expect(res['data']['subscription']['paymentCycle']).to eq(body[:subscription][:paymentCycle])
        expect(res['data']['subscription']['paymentMethod']).to eq(body[:subscription][:paymentMethod])
        expect(res['data']['subscription']['firstPaymentDate']).to eq(body[:subscription][:firstPaymentDate])
        expect(res['data']['subscription']['remarks']).to eq(body[:subscription][:remarks])
        expect(res['data']['subscription']['isPaused']).to eq(body[:subscription][:isPaused])
      end
    end
  end
end
