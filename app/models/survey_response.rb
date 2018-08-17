class SurveyResponse < ApplicationRecord
  extend FriendlyId
  include Slugger

  belongs_to :survey
  belongs_to :respondent
  belongs_to :web_link
  has_many :charism_scores, dependent: :destroy
  has_many :question_responses, dependent: :destroy

  friendly_id :easy_slug, use: :slugged

  def self.completed
    joins(:charism_scores).uniq
  end

  def completed?
    charism_scores.any?
  end
end