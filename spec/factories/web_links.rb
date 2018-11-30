FactoryBot.define do
  factory :web_link do
    survey
    organization
    name { "Knights of Columbus" }

    trait(:default) do
      name { WebLink::DEFAULT_GROUP_NAME }
      survey { Survey.default }
    end
  end
end
