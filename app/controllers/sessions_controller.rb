class SessionsController < ApplicationController
  def new
    @login_errors = []
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully.'
    else
      @login_errors = []
      @login_errors << "Invalid email or password"
      flash.now[:alert] = 'Invalid login credentials'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'Logged out successfully.'
  end
end
