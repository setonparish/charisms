class DistributionGroup < ApplicationRecord
  extend FriendlyId
  include Slugger

  belongs_to :survey
  has_many :survey_responses

  validates :name, presence: true

  friendly_id :easy_slug, use: :slugged
end
