FactoryBot.define do
  factory :question_response do
    survey_response
    question
    sequence(:position)
    answer "My Answer"
  end
end
