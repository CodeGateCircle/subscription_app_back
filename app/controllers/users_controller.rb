class UsersController < ApplicationController

    def create
        params = create_params

        user = User.create({
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

        user = User.find(params[:id]).update(currency: params[:currency], language: params[:language])

        render :json => {data:user}
    end

    # strong parameter
    def create_params
        params.permit(:language, :currency)
    end

    def update_params
        params.permit(:id, :language, :currency)
    end

end
