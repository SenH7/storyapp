class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])

    # Security check: only allow users to delete their own account
    if @user != current_user
      redirect_to root_path, alert: "You can only delete your own account."
      return
    end

    # Delete the session to log the user out
    session.delete(:user_id)

    # Delete the user
    @user.destroy

    redirect_to root_path, notice: "Your account has been successfully deleted."
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
