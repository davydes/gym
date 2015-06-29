FactoryGirl.define do
  factory :identity do
    sequence(:provider) { |n| "provider#{n}" }
    sequence(:uid) { |n| n }
    association :user, factory: :user
  end
end