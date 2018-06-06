class SurveyResponsesController < ApplicationController
  before_action :require_respondent

  def new
  end

  def create
    if @survey_response = SurveyResponseCreator.new(survey: survey, respondent: respondent).run
      redirect_to answer_survey_path(@survey_response)
    else
      flash.now[:alert] = "We had an error creating your survey"
      render :new
    end
  end


  private

  def require_respondent
    redirect_to new_respondent_path unless respondent
  end

  def respondent
    @respondent ||= Respondent.find_by(id: session[:respondent_id])
  end

  def survey
    @survey ||= Survey.first
  end
end
