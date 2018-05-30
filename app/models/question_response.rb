class QuestionResponse < ApplicationRecord
  belongs_to :survey_response
  belongs_to :question

  validates :question, uniqueness: { scope: [:survey_response] }

  def self.unanswered
    where(answer: nil)
  end

  def answered?
    !unanswered?
  end

  def unanswered?
    answer.blank?
  end
end
