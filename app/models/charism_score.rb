class CharismScore < ApplicationRecord
  belongs_to :survey_response
  belongs_to :charism

  validates :score, numericality: { only_integer: true }
end
