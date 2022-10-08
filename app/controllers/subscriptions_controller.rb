class SubscriptionsController < ApplicationController
  require './app/firestore/firestore'

  def create
    params = create_params
    subscription = Subscription.create!({
      user_id: params[:userId],
      name: params[:subscription][:name],
      price: params[:subscription][:price],
      first_payment_date: params[:subscription][:firstPaymentDate],
      remarks: params[:subscription][:remarks],
      is_paused: params[:subscription][:isPaused],
      payment_cycle: params[:subscription][:paymentCycle],
      payment_method: params[:subscription][:paymentMethod],
    })
    if params[:subscription][:image] then
      url = Firestore.save_image_and_get_url(params[:subscription][:image], subscription.id.to_s)
      subscription.update(
          image_url: url
      )
    end
    render :json => { data: { subscription: subscription.format_res } }
  end

  def show
    params = show_params

    subscriptions = Subscription.where(user_id: params[:userId])

    subscriptions = subscriptions.map { |s| s.format_res }
    render :json => { data: { subscriptions: subscriptions } }
  end

  def delete
    params = delete_params

    subscription = Subscription.find(params[:id]).destroy

    render :json => {data: { subscription: subscription.format_res}}
  end

  def update
    params = update_params
    subscription = Subscription.find(params[:id])
    update_params = {
      user_id: params[:userId],
      name: params[:subscription][:name],
      price: params[:subscription][:price],
      first_payment_date: params[:subscription][:firstPaymentDate],
      remarks: params[:subscription][:remarks],
      is_paused: params[:subscription][:isPaused],
      payment_cycle: params[:subscription][:paymentCycle],
      payment_method: params[:subscription][:paymentMethod],
    }
    if params[:subscription][:image] then
      url = Firestore.save_image_and_get_url(params[:subscription][:image], subscription.id.to_s)
      update_params[:image_url] = url
    end
    subscription.update!(update_params)
    render :json => { data: subscription.format_res }
  end

  def search

    name = params[:name]

    if name
      subscriptions = Subscription.where(name: name).select(:name, :price, :payment_cycle, :image_url)
    else
      subscriptions = Subscription.where(user_id: "tester").select(:name, :price, :payment_cycle, :image_url)
    end

    subscriptions = subscriptions.map { |s| s.format_res_search }

    render :json => { data: { result: subscriptions } }

  end

  # strong parameter
  def create_params
    params.permit(:userId, subscription: [:name, :price, :firstPaymentDate, :remarks, :isPaused, :image, :paymentCycle, :paymentMethod])
  end

  def show_params
    params.permit(:userId)
  end

  def delete_params
    params.permit(:id)
  end

  def update_params
    params.permit(:id, :userId, subscription: [:name, :price, :firstPaymentDate, :remarks, :isPaused, :image, :paymentCycle, :paymentMethod])
  end
end
