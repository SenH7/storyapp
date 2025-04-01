class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_api_request, only: [:create]

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = generate_token(@user.id)
      render json: {
        status: 'success',
        token: token,
        user: {
          id: @user.id,
          email: @user.email,
          username: @user.personal_information&.username
        }
      }
    else
      render json: {
        status: 'error',
        errors: ['Invalid email or password']
      }, status: :unauthorized
    end
  end

  def destroy
    render json: { message: 'Successfully logged out' }
  end

  private

  def generate_token(user_id)
    payload = { user_id: user_id }
    JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')
  end
end