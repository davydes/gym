FactoryGirl.define do
  factory :body_part do
    sequence (:alias) { |n| "alias#{n}" }
    name 'Example Name'
    description 'Example Description'

    factory :body_part_with_muscle do
      after(:create) do |body_part|
        create(:muscle, body_parts: [body_part])
      end
    end
  end
end