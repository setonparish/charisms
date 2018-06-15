class QuestionOrder < ApplicationRecord
  belongs_to :survey, inverse_of: :question_order
  belongs_to :question

  acts_as_list scope: :survey
end
