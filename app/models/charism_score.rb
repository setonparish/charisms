class CharismScore < ApplicationRecord
  belongs_to :survey_response
  belongs_to :charism
  has_one :respondent, through: :survey_response

  validates :score, numericality: { only_integer: true }
end
