# ベースとなるイメージを指定
FROM ruby:3.1.2

# ビルド時に実行するコマンドの指定。
# インストール可能なパッケージの一覧の更新
RUN apt-get update -qq\
# パッケージのインストール
&& apt-get install -y postgresql-client

RUN mkdir /subscription_app_back

# 作業ディレクトリの指定
WORKDIR /subscription_app_back
COPY Gemfile /subscription_app_back/Gemfile
COPY Gemfile.lock /subscription_app_back/Gemfile.lock
RUN bundle install
COPY . /subscription_app_back

# コンテナ起動時に毎回実行されるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# イメージの実行時に実行するメインプロセスの設定
CMD ["rails", "server", "-b", "0.0.0.0"]
