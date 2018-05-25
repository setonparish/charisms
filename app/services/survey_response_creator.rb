#
# This class is responsible for creating a new SurveyResponse with a QuestionResponse
# for each Question on a Survey.  In other words, create blank "answers" for every
# "question" on a survey.
#
class SurveyResponseCreator
  def initialize(respondent:, survey:)
    @respondent = respondent
    @survey = survey
  end

  def run
    SurveyResponse.where(respondent: @respondent, survey: @survey).first_or_initialize.tap do |survey_response|
      @survey.questions.each do |question|
        survey_response.question_responses.where(question: question).first_or_initialize
      end

      survey_response.save
    end
  end
end
