class ProfilesController < ApplicationController
  before_action :require_login
  def edit
    @user = current_user
    @user.build_personal_information if @user.personal_information.nil?
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_profile_path, notice: 'Profile updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 personal_information_attributes: [:username, :city, :country, :user_image])
  end
end
