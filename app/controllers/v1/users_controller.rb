module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
      user = User.create!(user_params)
      render json: user, serializer: SessionSerializer, root: nil
    rescue => e
      render json: { error: t('user_controller.user_create_error') }, status: :unprocessable_entity
    end

    private

    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end
  end
end
