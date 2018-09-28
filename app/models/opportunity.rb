class Opportunity < ApplicationRecord
  belongs_to :organization

  validates :name, presence: true, uniqueness: { scope: :organization }
end
