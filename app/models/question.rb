class Question < ApplicationRecord
  belongs_to :charism
  has_one :question_order

  validates :text, presence: true
end
