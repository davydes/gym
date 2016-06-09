FactoryGirl.define do
  factory :journal_item, class: 'Journal::Item' do
    executed_at 1.days.ago

    trait :with_journal do
      journal factory: [ :journal, :with_user ]
    end

    trait :with_workout do
      workout factory: [ :workout, :with_items ]
    end
  end
end
