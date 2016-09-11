FactoryGirl.define do
  factory :user do

    transient do
      sequence (:name) { |n| "user#{n}" }
    end

    email { "#{name}@example.org" }
    password "secret88"
    password_confirmation "secret88"

    factory :admin do
      admin true
    end
  end
end
