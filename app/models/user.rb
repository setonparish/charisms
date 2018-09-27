class User < ApplicationRecord
  has_secure_password

  has_many :web_links
  has_many :organization_memberships, dependent: :destroy
  has_many :organizations, through: :organization_memberships

  validates :email, presence: true, uniqueness: true

  def self.authenticate(email, password)
    find_with_email(email).try(:authenticate, password)
  end

  def self.find_with_email(email)
    where("LOWER(email) = LOWER(?)", email).first
  end
end
