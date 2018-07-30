FactoryBot.define do
  factory :web_link do
    survey
    name "Knights of Columbus"

    trait(:default) do
      name WebLink::DEFAULT_GROUP_NAME
    end
  end
end
