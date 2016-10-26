FactoryGirl.define do
  factory :equipment, class: 'References::Equipment' do
    sequence (:alias) { |n| "body_part#{n}" }
    name "Equipment Test Name"
    description "Equipment Test Description"
  end
end
