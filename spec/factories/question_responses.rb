FactoryBot.define do
  factory :question_response do
    survey_response
    question
    sequence(:position)
    answer "3"
  end
end
