class ApplicationController < ActionController::API
  include AbstractController::Translation
  respond_to :json

  before_action :authenticate_user_from_token!

  private

  def authenticate_user_with_token
    grant_access || deny_access
  end

  def grant_access
    return false unless auth_token.include? ':'
    id, access_token = auth_token.split ':'
    user = User.find(id)
    if user && Devise.secure_compare(user.access_token, access_token)
      sign_in user, store: false
    else
      false
    end
  end

  def deny_access
    render json: {error: t(:unauthorized)}, status: 401
  end

  def auth_token
    @auth_token ||= request.headers['Authorization']
  end
end
