class Charism < ApplicationRecord
  has_many :questions
  has_many :charism_scores, dependent: :destroy
  has_many :charism_opportunities, dependent: :destroy
  has_many :opportunities, through: :charism_opportunities, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def opportunities_for(organization)
    opportunities.joins(:organization).where(organization: organization).distinct
  end
end
