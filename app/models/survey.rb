class Survey < ApplicationRecord
  has_many :question_order, -> { order(position: :asc) }, inverse_of: :survey, dependent: :destroy
  has_many :questions, through: :question_order

  validates :name, presence: true
end
