#
# This class is responsible for creating a new SurveyResponse with a QuestionResponse
# for each Question on a Survey.  In other words, create blank "answers" for every
# "question" on a survey.
#
class SurveyResponseCreator
  def initialize(respondent:, survey:, web_link:)
    @respondent = respondent
    @survey = survey
    @web_link = web_link
  end

  def run
    SurveyResponse.where(respondent: @respondent, survey: @survey, web_link: @web_link).first_or_initialize.tap do |survey_response|
      @survey.question_order.includes(:question).each do |question_order|
        survey_response.question_responses
                       .where(question: question_order.question)
                       .first_or_initialize(position: question_order.position)
      end

      survey_response.save!
    end
  end
end
