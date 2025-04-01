class Api::V1::RegistrationsController < Api::V1::BaseController
  skip_before_action :authenticate_api_request, only: [:create]

  def create
    @user = User.new(user_params)

    if @user.save
      token = JwtService.encode(user_id: @user.id)
      render json: {
        status: 'success',
        token: token,
        user: @user
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
end