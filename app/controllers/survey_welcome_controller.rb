class SurveyWelcomeController < ApplicationController
  def new
    session[:web_link_id] = web_link.id
  end

  private

  def web_link
    if slug = params[:web_link_slug]
      # a custom link was provided
      WebLink.friendly.find(slug)
    else
      # TODO: scope this `WebLink` to the admin user
      # no custom link was used, so associate to a default group
      WebLink.default
    end
  end
end
