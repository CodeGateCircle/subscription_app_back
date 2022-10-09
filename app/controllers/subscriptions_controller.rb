class SubscriptionsController < ApplicationController
  require './app/firestore/firestore'

  def create
    params = create_params

    if !User.exists?(user_id: params[:userId])
      render status: 404, :json => {
        errors: {
          field: "user_id",
          message: "ユーザーIDが登録されていません。"
        }
      }
      return
    end

    if URI.regexp.match(params[:subscription][:imageUrl]).nil?
      params[:subscription][:imageUrl] = nil
    end

    subscription = Subscription.create!({
      user_id: params[:userId],
      name: params[:subscription][:name],
      price: params[:subscription][:price],
      first_payment_date: params[:subscription][:firstPaymentDate],
      remarks: params[:subscription][:remarks],
      is_paused: params[:subscription][:isPaused],
      payment_cycle: params[:subscription][:paymentCycle],
      payment_method: params[:subscription][:paymentMethod],
      image_url: params[:subscription][:imageUrl]
    })
    begin
      if params[:subscription][:image] then
        url = Firestore.save_image_and_get_url(params[:subscription][:image], subscription.id.to_s)
        subscription.update(
          image_url: url
        )
      end
    rescue
      render status: 200, :json => {
        data: {
          subscription: subscription.format_res
        },
        errors: {
          field: "image",
          message: "画像の保存に失敗しました。"
        }
      }
      return
    end
    render status: 200, :json => { data: { subscription: subscription.format_res } }

  end

  def show
    params = show_params

    subscriptions = Subscription.where(user_id: params[:userId])

    subscriptions = subscriptions.map { |s| s.format_res }
    render status:200, :json => { data: { subscriptions: subscriptions } }
  end

  def delete
    params = delete_params

    subscription = Subscription.find(params[:id]).destroy

    render status: 200, :json => {data: { subscription: subscription.format_res}}
  end

  def update
    params = update_params

    if !User.exists?(user_id: params[:userId])
      render status: 404, :json => {
        errors: {
          field: "user_id",
          message: "ユーザーIDが登録されていません。"
        }
      }
      return
    end

    if !Subscription.where(user_id: params[:userId]).exists?(id: params[:id])
      render status: 404, :json => {
        errors: {
          field: "subscription_id",
          message: "サブスクIDが違います。"
        }
      }
      return
    end

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
    subscription.update!(update_params)
    begin
      if params[:subscription][:image] then
        url = Firestore.save_image_and_get_url(params[:subscription][:image], subscription.id.to_s)
        update_params[:image_url] = url
      end
      subscription.update!(update_params)
    rescue
      render status: 200, :json => {
        data: {
          subscription: subscription.format_res
        },
        errors: {
          field: "image",
          message: "画像の保存に失敗しました。"
        }
      }
      return
    end
    render status: 200, :json => { data: { subscription: subscription.format_res } }
  end

  def search

    subscription_table = Subscription.arel_table

    if params[:name]
      para = "%#{params[:name]}%"
      subscriptions = Subscription.where(subscription_table[:name].matches(para)).select(:name, :price, :payment_cycle, :image_url)
    else
      subscriptions = Subscription.where(user_id: "tester").select(:name, :price, :payment_cycle, :image_url)
    end

    subscriptions = subscriptions.map { |s| s.format_res_search }

    render status: 200, :json => { data: { result: subscriptions } }

  end

  # strong parameter
  def create_params
    params.permit(:userId, subscription: [:name, :price, :firstPaymentDate, :remarks, :isPaused, :image, :paymentCycle, :paymentMethod, :imageUrl])
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
