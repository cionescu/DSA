module Api
  class UsersController < ApplicationController
    before_action :find_user, :find_target, only: [:follow, :unfollow]

    rescue_from ActiveRecord::RecordNotFound do |err|
      object_not_found = @user ? 'target' : 'user'
      render json: {
        errors: {
          message: err.message,
          object_not_found: object_not_found
        }
      }, status: :not_found
    end

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

    def followers
    end

    def follow
      if @user.follow(@target)
        head :ok
      else
        render json: {
          errors: "user already follows target"
        }, status: :unprocessable_entity
      end
    end

    def unfollow
      if @user.unfollow(@target)
        head :ok
      else
        render json: {
          errors: "user didn't follow target"
        }, status: :unprocessable_entity
      end
    end

    private

    def permitted_params
      params.require(:user).permit(:name, :username)
    end

    def find_user
      @user = User.find params.require(:user_id)
    end

    def find_target
      @target = User.find params.require(:id)
    end
  end
end
