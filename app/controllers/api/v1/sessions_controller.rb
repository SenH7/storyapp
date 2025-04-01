class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_api_request, only: [:create]

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = JwtService.encode(user_id: @user.id)
      render json: {
        status: 'success',
        token: token,
        user: @user
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
end