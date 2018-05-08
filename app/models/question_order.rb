class QuestionOrder < ApplicationRecord
  belongs_to :survey
  belongs_to :question

  acts_as_list scope: :survey
end
