class QuestionResponsesController < ApplicationController
  before_action :assign_wizard
  helper_method :next_question_path

  layout "survey"

  def edit
  end

  def update
    if @wizard.current.update(question_response_params)
      if @wizard.survey_completed?
        # calculate scores for each charism
        CharismScoreCreator.new(survey_response: @wizard.survey_response).run
      end
      redirect_to next_question_path, turbolinks: true
    else
      flash.now[:alert] = "There was an error saving your answer."
      render :edit
    end
  end


  private

  def question_response_params
    params.require(:question_response).permit(:answer)
  end

  def assign_wizard
    @wizard ||= begin
      survey_response = SurveyResponse.friendly.find(params[:survey_response_id])
      question_response = survey_response.question_responses.find_by(position: params[:question_response_position])
      QuestionResponseWizard.new(survey_response: survey_response, question_response: question_response)
    end
  end

  def next_question_path
    if !@wizard.next && @wizard.survey_completed?
      # charism score summary page
      # survey_result_path(@wizard.survey_response)
      answer_survey_question_path(@wizard.survey_response, @wizard.next.position)

    elsif @wizard.only_unanswered_questions_remaining?
      # survey path without specific question as part of path
      # answer_survey_path(@wizard.survey_response)
      answer_survey_question_path(@wizard.survey_response, @wizard.next.position)

    else
      # survey path with specific question as part of path
      answer_survey_question_path(@wizard.survey_response, @wizard.next.position)
    end
  end
end
