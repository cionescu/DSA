FactoryBot.define do
  factory :review do
    score { rand(1..5) }
    sequence(:title) { |n| "Review#{n}" }
  end
end
