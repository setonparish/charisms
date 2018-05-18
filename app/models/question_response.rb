class QuestionResponse < ApplicationRecord
  belongs_to :survey_response
  belongs_to :question

  validates :answer, presence: :true, uniqueness: { scope: [:survey_response, :question], message: "has already been given" }
end
