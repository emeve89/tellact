module V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
      user = User.find_for_database_authentication(username: params[:username])
      if user.valid_password?(params[:password])
        sign_in :user, user
        render json: user, serializer: SessionSerializer, root: nil
      end
    rescue => e
      invalid_login_attempt
    end

    private

    def invalid_login_attempt
      warden.custom_failure!
      render json: {error: t('session_controller.invalid_login_attempt')}, status: :unprocessable_entity
    end
  end
end
