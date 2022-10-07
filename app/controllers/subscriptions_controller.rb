class SubscriptionsController < ApplicationController
    require './app/firestore/firestore'

    def create
        params = create_params
        subscription = Subscription.create({
            user_id: params[:userId],
            name: params[:subscription][:name],
            price: params[:subscription][:price],
            first_payment_date: params[:subscription][:firstPaymentDate],
            remarks: params[:subscription][:remarks],
            is_paused: params[:subscription][:isPause],
            payment_cycle: params[:subscription][:paymentCycle],
            payment_method: params[:subscription][:paymentMethod],
        })
        url = Firestore.save_image_and_get_url(params[:subscription][:image], subscription.id.to_s)
        subscription.update(
            image_url: url
        )
        render :json => {data:subscription}
    end

    def show
        params = show_params

        subscriptions = Subscription.where(user_id: params[:user_id])

        render :json => {data:{subscriptions:subscriptions}}
    end

    def delete
        params = delete_params

        subscription = Subscription.find(params[:id]).destroy

        render :json => {data:{subscription:subscription}}
    end

    def update
        params = update_params

        subscription = Subscription.find(params[:id])

        subscription.update(
            user_id: params[:userId],
            name: params[:subscription][:name],
            price: params[:subscription][:price],
            first_payment_date: params[:subscription][:firstPaymentDate],
            remarks: params[:subscription][:remarks],
            is_paused: params[:subscription][:isPause],
            image_url: params[:subscription][:imageUrl],
            payment_cycle: params[:subscription][:paymentCycle],
            payment_method: params[:subscription][:paymentMethod],
        )

        render :json => {data:subscription}
    end

    # strong parameter
    def create_params
        params.permit(:userId, subscription: [:name, :price, :firstPaymentDate, :remarks, :isPause, :image, :paymentCycle, :paymentMethod])
    end

    def show_params
        params.permit(:user_id)
    end

    def delete_params
        params.permit(:id)
    end

    def update_params
        params.permit(:id, :userId, subscription: [:name, :price, :firstPaymentDate, :remarks, :isPause, :imageUrl, :paymentCycle, :paymentMethod])
    end
end
