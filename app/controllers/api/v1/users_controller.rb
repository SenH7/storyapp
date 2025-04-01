class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authenticate_api_request, only: [:show_public]
  before_action :set_user, only: [:show_public]

  # GET /api/v1/profile - Current user's profile
  def show
    render json: current_api_user, include: 'personal_information'
  end

  # GET /api/v1/users/:id - Public profile of a user
  def show_public
    render json: @user, include: 'personal_information'
  end

  # PATCH /api/v1/profile - Update current user's profile
  def update
    if current_api_user.update(user_params)
      render json: current_api_user, include: 'personal_information'
    else
      render json: { errors: current_api_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end

  def user_params
    params.require(:user).permit(
      :password,
      :password_confirmation,
      personal_information_attributes: [:id, :username, :city, :country, :user_image]
    )
  end
end