class QuestionResponse < ApplicationRecord
  belongs_to :survey_response
  belongs_to :question

  validates :question, :position, uniqueness: { scope: [:survey_response] }
  validates :answer, presence: true, on: :update

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
