FactoryGirl.define do
  factory :body_part do
    sequence (:alias) { |n| "alias#{n}" }
    name 'Example Name'
    description 'Example Description'
  end
end
