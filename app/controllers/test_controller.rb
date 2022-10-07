class TestController < ApplicationController
  require './app/firestore/firestore'
  def create

    # path = Firestore.add_image_from_base64(params[:image], '12')
    # url = Firestore.get_image_url(path)
    url = Firestore.save_image_and_get_url(params[:image], '12')
    render json: {data: url}
  end
end
