FactoryGirl.define do
  factory :muscle do
    sequence (:alias) { |n| "alias#{n}" }
    name 'Example Name'
    description 'Example Description'
    shape 'long'
  end
end
