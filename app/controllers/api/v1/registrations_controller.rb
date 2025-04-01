class Api::V1::RegistrationsController < Api::V1::BaseController
  skip_before_action :authenticate_api_request, only: [:create]

  def create
    @user = User.new(user_params)

    if @user.save
      token = generate_token(@user.id)
      render json: {
        status: 'success',
        token: token,
        user: ActiveModelSerializers::SerializableResource.new(@user)
      }, status: :created
    else
      render json: {
        status: 'error',
        errors: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def generate_token(user_id)
    payload = { user_id: user_id }
    JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')
  end
end