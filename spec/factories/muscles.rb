FactoryGirl.define do
  factory :muscle do
    sequence (:alias) { |n| "muscle#{n}" }
    name 'Example Muscle'
    description 'Muscle Description'
    shape 'long'

    factory :muscle_with_body_part do
      after(:create) do |muscle|
        create(:body_part, muscles: [muscle])
      end
    end

    factory :muscle_with_exercise do
      after(:create) do |muscle|
        create(:exercise, muscles: [muscle])
      end
    end
  end
end
