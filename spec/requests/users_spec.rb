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
        expect(res['data']['user_id']).to eq(@user[:id])
        expect(res['data']['currency']).to eq(@user[:currency])
        expect(res['data']['language']).to eq(@user[:language])
      end
    end
  end
end
