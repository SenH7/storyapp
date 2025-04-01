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
    decoded_token = JwtService.decode(token)

    if decoded_token.nil?
      render json: { error: 'Invalid token' }, status: :unauthorized
      return
    end

    @current_api_user = User.find_by(id: decoded_token['user_id'])
    unless @current_api_user
      render json: { error: 'User not found' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :unauthorized
  end

  def current_api_user
    @current_api_user
  end
end