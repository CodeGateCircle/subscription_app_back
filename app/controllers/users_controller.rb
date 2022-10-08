class UsersController < ApplicationController

    def create
        params = create_params

        user = User.create!({
            user_id: params[:userId],
            currency: params[:currency],
            language: params[:language],
        })

        render :json => { data: user.format_res }
    end

    def show
        user = User.find(params[:id])

        render :json => { data: user.format_res }
    end

    def update
        params = update_params

        user = User.find(params[:userId])
        user.update!(currency: params[:currency], language: params[:language])

        render :json => { data: user.format_res }
    end

    # strong parameter
    def create_params
        params.permit(:userId, :language, :currency)
    end

    def update_params
        params.permit(:userId, :language, :currency)
    end

end
