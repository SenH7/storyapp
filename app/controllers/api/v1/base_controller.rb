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
    decoded_token = decode_token(token)

    if decoded_token.nil?
      render json: { error: 'Invalid token' }, status: :unauthorized
      return
    end

    @current_api_user = User.find_by(id: decoded_token['user_id'])
    unless @current_api_user
      render json: { error: 'User not found' }, status: :unauthorized
    end
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :unauthorized
  end

  def current_api_user
    @current_api_user
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')[0]
  rescue
    nil
  end
end