class Question < ApplicationRecord
  belongs_to :charism

  validates :text, presence: true
end
