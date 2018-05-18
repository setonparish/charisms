class SurveyResponse < ApplicationRecord
  extend FriendlyId

  belongs_to :survey
  belongs_to :respondent
  has_many :question_responses, dependent: :destroy

  friendly_id :easy_slug, use: :slugged


  private

  # easy to type identifier consisting
  # of lowercase alphanumeric characters
  def easy_slug
    [*("a".."z"),*(0..9)].shuffle[0,12].join
  end
end
