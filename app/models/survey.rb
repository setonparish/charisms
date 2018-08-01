class Survey < ApplicationRecord
  DEFAULT_NAME = "Spiritual Gifts"

  has_many :question_order, -> { order(position: :asc) }, inverse_of: :survey, dependent: :destroy
  has_many :questions, through: :question_order

  validates :name, presence: true

  def self.default
    find_by(name: DEFAULT_NAME)
  end
end
