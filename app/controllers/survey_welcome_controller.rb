class SurveyWelcomeController < ApplicationController
  def new
    session[:distribution_group_id] = distribution_group.id
  end

  private

  def distribution_group
    if slug = params[:distribution_group_slug]
      # a custom link was provided
      DistributionGroup.friendly.find(slug)
    else
      # TODO: scope this `DistributionGroup` to the admin user
      # no custom link was used, so associate to a default group
      DistributionGroup.find_by!(name: DistributionGroup::DEFAULT_GROUP_NAME)
    end
  end
end
