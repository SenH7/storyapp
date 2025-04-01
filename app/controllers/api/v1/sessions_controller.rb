class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_api_request, only: [:create]

  def create
    email = params[:email] || params.dig(:user, :email) || params.dig(:session, :user, :email)
    password = params[:password] || params.dig(:user, :password) || params.dig(:session, :user, :password)
    @user = User.find_by(email: email)

    if @user&.authenticate(password)
      token = generate_token(@user.id)
      render json: {
        status: 'success',
        token: token,
        user: ActiveModelSerializers::SerializableResource.new(@user)
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