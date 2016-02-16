FactoryGirl.define do
  factory :user do
    sequence (:name) { |n| "user#{n}" }
    first_name { "firstname_#{name}" }
    last_name { "lastname_#{name}" }
    gender { [:f, :m].sample }
    country { ['country 1', 'country 2', 'country 3'].sample }
    city { ['city 1','city 2','city 3'].sample }
    date_of_birth { rand(18..90).year.ago }
    email { "#{name}@example.org" }
    password "secret88"
    password_confirmation "secret88"

    factory :admin do
      admin true
    end
  end
end
