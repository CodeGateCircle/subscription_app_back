class SubscriptionsController < ApplicationController

    def create
        params = create_params

        subscription = Subscription.create({
            user_id: params[:userId],
            name: params[:subscription][:name],
            price: params[:subscription][:price],
            first_payment_date: params[:subscription][:firstPaymentDate],
            remarks: params[:subscription][:remarks],
            is_paused: params[:subscription][:isPause],
            image_url: params[:subscription][:imageUrl],
            payment_cycle: params[:subscription][:paymentCycle],
            payment_method: params[:subscription][:paymentMethod],
        })

        render :json => {data:subscription}
    end

    def create_params
        params.permit(:userId, subscription: [:name, :price, :firstPaymentDate, :remarks, :isPause, :imageUrl, :paymentCycle, :paymentMethod])
    end

end