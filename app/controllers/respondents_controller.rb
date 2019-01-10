class RespondentsController < ApplicationController
  layout "survey"

  def new
    @respondent = Respondent.new
  end

  def create
    @respondent = Respondent.new(respondent_params)

    if @respondent.save
      survey_response = SurveyResponseCreator.new(survey: web_link.survey, web_link: web_link, respondent: @respondent).run
      redirect_to answer_survey_path(survey_response), turbolinks: true
    else
      flash.now[:alert] = "Please fix the problems in the form below"
      render :new
    end
  end


  private

  def web_link
    WebLink.find(session[:web_link_id])
  end

  def respondent_params
    params.require(:respondent).permit(:first_name, :last_name, :email)
  end
end
