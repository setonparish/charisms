class RespondentsController < ApplicationController
  def new
    @respondent = Respondent.new
  end

  def create
    @respondent = Respondent.new(respondent_params)

    if @respondent.save
      survey_response = SurveyResponseCreator.new(survey: distribution_group.survey, distribution_group: distribution_group, respondent: @respondent).run
      redirect_to answer_survey_path(survey_response)
    else
      flash.now[:alert] = "Please fix the problems in the form below"
      render :new
    end
  end


  private

  def distribution_group
    DistributionGroup.find(session[:distribution_group_id])
  end

  def respondent_params
    params.require(:respondent).permit(:first_name, :last_name, :email)
  end
end
