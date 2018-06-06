class RespondentsController < ApplicationController
  def new
    @respondent = Respondent.new
  end

  def create
    @respondent = Respondent.new(respondent_params)

    if @respondent.save
      session[:respondent_id] = @respondent.id
      redirect_to begin_survey_path
    else
      flash.now[:alert] = "Please fix the problems in the form below"
      render :new
    end
  end


  private

  def respondent_params
    params.require(:respondent).permit(:first_name, :last_name, :email)
  end
end
