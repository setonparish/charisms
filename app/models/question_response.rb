class QuestionResponse < ApplicationRecord
  belongs_to :survey_response
  belongs_to :question

  validates :question, uniqueness: { scope: [:survey_response] }
end
