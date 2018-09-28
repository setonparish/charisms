FactoryBot.define do
  factory :question_response do
    survey_response
    question
    sequence(:position)
    answer { "3" }

    transient do
      charism { nil }
    end

    after :create do |model, options|
      model.question.update(charism: options.charism) if options.charism
    end
  end
end
