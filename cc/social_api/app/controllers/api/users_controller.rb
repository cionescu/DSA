module Api
  class UsersController < ApplicationController
    before_action :find_user

    def create
      user = User.new(permitted_params)
      if user.save
        render json: UserSerializer.new(user).serializable_hash
      else
        render json: {
          errors: user.errors
        }, status: :unprocessable_entity
      end
    end

    def follow
      @user.follow(params.require(:follower_id))
    end

    def unfollow
    end

    private

    def permitted_params
      params.require(:user).permit(:name, :username)
    end

    def find_user
      @user = User.find params.require(:user_id)
    end
  end
end
