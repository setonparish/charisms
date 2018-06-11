class QuestionResponse < ApplicationRecord
  belongs_to :survey_response
  belongs_to :question

  validates :question, :position, uniqueness: { scope: [:survey_response] }
  validates :answer, presence: true, on: :update
  validates :answer, numericality: { only_integer: true }, inclusion: { in: LikertScale.scores }, allow_blank: true

  def self.unanswered
    where(answer: nil)
  end

  def self.answered
    where.not(answer: nil)
  end

  def answered?
    !unanswered?
  end

  def unanswered?
    answer.blank?
  end
end
