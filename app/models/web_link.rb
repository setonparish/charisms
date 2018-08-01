class WebLink < ApplicationRecord
  extend FriendlyId
  include Slugger

  belongs_to :survey
  belongs_to :user
  has_many :survey_responses

  DEFAULT_GROUP_NAME = "Disconnected Responses"

  validates :name, presence: true, uniqueness: { scope: :user }

  friendly_id :easy_slug, use: :slugged

  def self.default
    find_by(name: DEFAULT_GROUP_NAME, survey: Survey.default)
  end
end
