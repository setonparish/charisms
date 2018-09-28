FactoryBot.define do
  factory :charism_score do
    survey_response
    charism
    score { 3 }
  end
end
