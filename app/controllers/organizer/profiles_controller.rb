class Organizer::ProfilesController < ApplicationController
  before_action :authenticate_user!
  layout "organizer"

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(profile_params)
      flash[:success] = "Updated profile"
      redirect_to edit_organizer_profile_path
    else
      flash.now[:alert] = "Could not update profile"
      render action: :edit
    end
  end


  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :email, :password)
  end
end
