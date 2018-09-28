FactoryBot.define do
  factory :user do
    first_name { "Padre" }
    last_name { "Pio" }
    sequence(:email) { |n| "padre.pio.#{n}@example.com" }
    password { "password" }
  end
end
