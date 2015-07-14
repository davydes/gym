FactoryGirl.define do
  factory :exercise do
    sequence (:alias) { |n| "exercise#{n}" }
    name 'Example Exercise'
    description 'Exercise Description'

    factory :exercise_with_muscle do
      after(:create) do |exercise|
        create(:muscle, exercises: [exercise])
      end
    end

    factory :exercise_with_body_part do
      after(:create) do |exercise|
        create(:body_part, exercises: [exercise])
      end
    end
  end
end