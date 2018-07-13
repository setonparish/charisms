class DistributionGroup < ApplicationRecord
  extend FriendlyId
  include Slugger

  belongs_to :survey

  validates :name, presence: true

  friendly_id :easy_slug, use: :slugged
end
