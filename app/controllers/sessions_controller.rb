class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if User.authenticate(session_params[:email], session_params[:password])
      # TODO: set login session cookie
      # TODO: redirect to organizer dashboard
      redirect_to root_path
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
