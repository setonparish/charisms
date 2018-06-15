class CharismScoresController < ApplicationController

  def show
    @charism_scores = survey_response.charism_scores.order(score: :desc)
  end


  private

  def survey_response
    @survey_response ||= SurveyResponse.friendly.find(params[:survey_response_id])
  end
end
