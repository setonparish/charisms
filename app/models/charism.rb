class Charism < ApplicationRecord
  has_many :questions
  has_many :charism_scores, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
