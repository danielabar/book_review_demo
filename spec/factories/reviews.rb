FactoryBot.define do
  factory :review do
    user { nil }
    book { nil }
    rating { 1 }
    body { "MyText" }
  end
end
