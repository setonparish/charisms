FactoryBot.define do
  factory :survey_response do
    survey
    distribution_group
    respondent
  end
end