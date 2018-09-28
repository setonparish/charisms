class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_organization

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_organization
    if current_user
      @current_organization ||= current_user.organizations.first!
    end
  end

  def authenticate_user!
    if current_user.nil?
      redirect_to login_path, alert: "You must be logged in to access this page."
    end
  end
end
