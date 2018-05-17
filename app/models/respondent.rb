class Respondent < ApplicationRecord
  validates :email, email: true, allow_blank: true

  def name
    [first_name, last_name].join(" ")
  end
end
