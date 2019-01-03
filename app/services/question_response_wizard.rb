class QuestionResponseWizard

  attr_reader :survey_response

  def initialize(survey_response:, question_response: nil)
    @survey_response = survey_response
    @question_response = question_response
  end

  def current
    @question_response ||
    questions.detect(&:unanswered?) ||
    questions.last
  end

  def question_number
    current.position
  end

  def number_questions
    questions.size
  end

  def previous
    previous_questions.last
  end

  def next
    remaining_questions.first
  end

  def can_manually_proceed?
    current.answered? && self.next.present?
  end

  def only_unanswered_questions_remaining?
    remaining_questions.all?(&:unanswered?)
  end

  def survey_completed?
    questions.all?(&:answered?)
  end


  private

  def previous_questions
    questions.select { |q| q.id < current.id }
  end

  def remaining_questions
    questions.select { |q| q.id > current.id }
  end

  def questions
    @questions ||= @survey_response.question_responses.order(:position)
  end
end
