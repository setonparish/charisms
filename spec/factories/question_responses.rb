FactoryBot.define do
  factory :question_response do
    survey_response
    question
    answer "My Answer"
  end
end
