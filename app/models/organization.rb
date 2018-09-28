class Organization < ApplicationRecord
  has_many :organization_memberships, dependent: :destroy
  has_many :users, through: :organization_memberships
  has_many :web_links, dependent: :destroy

  validates :name, presence: true
end
