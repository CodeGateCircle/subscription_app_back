class TestController < ApplicationController
  require './app/firestore/firestore'

  def create
    url = Firestore.save_image_and_get_url(params[:image], '12')
    render json: {data: url}
  end
end
