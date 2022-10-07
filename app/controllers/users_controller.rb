class UsersController < ApplicationController

    def create
        params = create_params

        user = User.create({
            user_id: params[:user_id],
            currency: params[:currency],
            language: params[:language],
        })

        render :json => {data:user}
    end

    def show
        user = User.find(params[:id])

        render :json => {data:user}
    end

    def update
        params = update_params

        user = User.find(params[:user_id]).update(currency: params[:currency], language: params[:language])

        render :json => {data:user}
    end

    # strong parameter
    def create_params
        params.permit(:user_id, :language, :currency)
    end

    def update_params
        params.permit(:user_id, :language, :currency)
    end

end
