FactoryBot.define do
  factory :entity do
    sequence(:name) { |n| "Entity#{n}" }

    trait :region do
      entity_type "REGION"
    end

    trait :area do
      entity_type "AREA"
    end

    trait :shop do
      entity_type "SHOP"
    end
  end
end
