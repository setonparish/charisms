#
# This class is responsible for calculating the individual charism scores for
# each question_response that is answered on a survey_response.
#
# One `CharismScore` record will be created for each `Charism` and will have a
# `score` set that is the sum of all answers tied to questions for that
# `Charism`.
#
class CharismScoreCreator
  def initialize(survey_response:)
    @survey_response = survey_response
  end

  def run
    charism_score_hash.map do |charism, question_responses|
      CharismScore.where(survey_response: @survey_response, charism: charism).first_or_initialize.tap do |cs|
        cs.max_score = LikertScale.max_score * question_responses.size
        cs.score = question_responses.sum { |qr| qr.answer.to_i }
        cs.save!
      end
    end
  end


  private

  # { <charism_obj>: [<question_response_obj>, <question_response_obj] }
  def charism_score_hash
    @survey_response.question_responses.includes(question: :charism).group_by do |qr|
      qr.question.charism
    end
  end
end
