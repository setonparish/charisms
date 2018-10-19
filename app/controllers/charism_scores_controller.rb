class CharismScoresController < ApplicationController
  def show
    @survey_organization = survey_response.web_link.organization
    @charism_scores = survey_response.charism_scores.includes(:charism).order(score: :desc)
  end


  private

  def survey_response
    @survey_response ||= SurveyResponse.friendly.find(params[:survey_response_id])
  end
end
