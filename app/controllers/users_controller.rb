class UsersController < ApplicationController
    def user_params
        params.require(:user).permit(:username, :password)
    end
    
    def new
    end

    def create
        @user = User.create!(user_params)
        redirect_to datacrunches_path(:username => @user.username)
    end
end
