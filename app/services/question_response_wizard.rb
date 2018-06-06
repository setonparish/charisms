class QuestionResponseWizard

  attr_reader :survey_response

  def initialize(survey_response:, question_response: nil)
    @survey_response = survey_response
    @question_response = question_response
  end

  def current
    @current ||= begin
      @question_response || @survey_response.question_responses.unanswered.first
    end
  end

  def previous
    @previous ||= previous_questions.last
  end

  def next
    @next ||= remaining_questions.first
  end

  def can_manually_proceed?
    current.answered? && self.next.present?
  end

  def only_unanswered_questions_remaining?
    remaining_questions.answered.none?
  end

  def survey_completed?
    @survey_response.question_responses.unanswered.count.zero?
  end


  private

  def previous_questions
    @survey_response.question_responses.where("id < ?", current)
  end

  def remaining_questions
    @survey_response.question_responses.where("id > ?", current)
  end
end
