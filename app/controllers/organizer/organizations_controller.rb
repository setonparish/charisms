class Organizer::OrganizationsController < ApplicationController
  before_action :authenticate_user!
  layout "organizer"

  def edit
    @organization = current_organization
  end

  def update
    @organization = current_organization

    if @organization.update(organization_params)
      flash[:success] = "Updated organization"
      redirect_to edit_organizer_organization_path
    else
      flash.now[:alert] = "Could not update organization"
      render action: :edit
    end
  end


  private

  def organization_params
    params.require(:organization).permit(:name)
  end
end
