class Question < ApplicationRecord
  belongs_to :charism
  has_one :question_order, dependent: :destroy

  validates :text, presence: true
end
