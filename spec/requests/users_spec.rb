require 'rails_helper'

RSpec.describe "Users", type: :request do

  before(:each) do
    @user = FactoryBot.create(:user)
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  describe "GET /account/:user_id" do
    context "成功" do
      it "指定したuser_idのユーザーが取得できる" do
        get "/account/#{@user.id}"
        expect(response).to have_http_status :ok
        res = JSON.parse(response.body)
        expect(res['data']['userId']).to eq(@user[:user_id])
        expect(res['data']['currency']).to eq(@user[:currency])
        expect(res['data']['language']).to eq(@user[:language])
      end
    end
  end

  describe "POST /account" do
    context "成功" do
      it "受け取ったResponseからユーザーを作成することができる" do
        body = {userId: "12332", currency: "JPY", language: "Japanese"}
        post "/account", params: body
        expect(response).to have_http_status :ok
        res = JSON.parse(response.body)
        expect(res['data']['userId']).to eq(body[:userId])
        expect(res['data']['currency']).to eq(body[:currency])
        expect(res['data']['language']).to eq(body[:language])
      end
    end
  end
end
