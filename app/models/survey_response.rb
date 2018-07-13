class SurveyResponse < ApplicationRecord
  extend FriendlyId
  include Slugger

  belongs_to :survey
  belongs_to :respondent
  has_many :charism_scores
  has_many :question_responses, dependent: :destroy

  friendly_id :easy_slug, use: :slugged
end
