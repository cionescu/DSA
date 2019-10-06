module Api
  class UsersController < ApplicationController
    def create
      user = User.new(permitted_params)
      if user.save
        render json: UserSerializer.new(user).serializable_hash
      else
        render json: {
          errors: user.errors
        }
      end
    end

    private

    def permitted_params
      params.require(:user).permit(:name, :username)
    end
  end
end
