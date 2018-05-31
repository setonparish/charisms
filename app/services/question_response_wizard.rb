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
    @previous ||= begin
      @survey_response.question_responses.where("id < ?", current).last
    end
  end

  def next
    @next ||= begin
      @survey_response.question_responses.where("id > ?", current).first
    end
  end

  def can_show_next?
    current.answered? && self.next.present?
  end

end
