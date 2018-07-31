class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if user = User.authenticate(session_params[:email], session_params[:password])
      session[:user_id] = user.id
      redirect_to organizer_dashboard_path
    else
      flash.now[:alert] = "An incorrect email or password was provided."
      @user = User.new(session_params)
      render :new
    end
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
