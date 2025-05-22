FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}_#{rand(1000)}@example.com" }
    password { "password123" }
  end
end
