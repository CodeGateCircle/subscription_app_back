class UsersController < ApplicationController

    def create
        params = create_params

        user = User.create({
            currency: params[:currency],
            language: params[:language],
        })

        render :json => {data:user}
    end

    def create_params
        params.permit(:language, :currency)
    end

end
