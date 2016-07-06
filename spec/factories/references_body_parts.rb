FactoryGirl.define do
  factory :body_part, class: 'References::BodyPart' do
    sequence (:alias) { |n| "body_part#{n}" }
    name 'Example BodyPart'
    description 'BodyPart Description'

    factory :body_part_with_muscle do
      after(:create) do |body_part|
        create(:muscle, body_parts: [body_part])
      end
    end

    factory :body_part_with_exercise do
      after(:create) do |body_part|
        create(:exercise, body_parts: [body_part])
      end
    end
  end
end