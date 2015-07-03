FactoryGirl.define do
  factory :muscle do
    sequence (:alias) { |n| "alias#{n}" }
    name 'Example Name'
    description 'Example Description'
    shape 'long'

    factory :muscle_with_body_part do
      after(:create) do |muscle|
        create(:body_part, muscles: [muscle])
      end
    end
  end
end
