FactoryGirl.define do
  factory :workout do
    sequence (:alias) { |n| "workout#{n}" }
    name 'Example Workout'
    description 'Workout Description'

    trait :with_items do
      after :create do |workout|
        create_list :workout_item, 3,
                    :workout => workout,
                    :exercise => create(:exercise)
      end
    end
  end
end