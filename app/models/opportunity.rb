class Opportunity < ApplicationRecord
  belongs_to :organization
  has_many :charism_opportunities, dependent: :destroy
  has_many :charisms, through: :charism_opportunities

  validates :name, presence: true, uniqueness: { scope: :organization }
end
