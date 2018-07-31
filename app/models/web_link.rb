class WebLink < ApplicationRecord
  extend FriendlyId
  include Slugger

  belongs_to :survey
  belongs_to :user
  has_many :survey_responses

  DEFAULT_GROUP_NAME = "Disconnected Responses"

  validates :name, presence: true

  friendly_id :easy_slug, use: :slugged
end
