FactoryGirl.define do
  factory :journal do

    trait :with_user do
      user factory: :user
    end

    trait :with_items do
      after :create do |journal|
        create_list :journal_item, 3,
                    :journal => journal,
                    :workout => create(:workout, :with_items)
      end
    end
  end
end
