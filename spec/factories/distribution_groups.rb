FactoryBot.define do
  factory :distribution_group do
    survey
    name "Knights of Columbus"

    trait(:default) do
      name DistributionGroup::DEFAULT_GROUP_NAME
    end
  end
end
