class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_api_request

  private

  def authenticate_api_request
    header = request.headers['Authorization']
    if header.blank?
      render json: { error: 'Authorization header missing' }, status: :unauthorized
      return
    end

    token = header.split(' ').last
    begin
      @decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')[0]
      @current_api_user = User.find(@decoded_token['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :unauthorized
    end
  end

  def current_api_user
    @current_api_user
  end
end