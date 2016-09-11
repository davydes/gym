FactoryGirl.define do
  factory :profile do
    user { create :user }   
    first_name { "firstname" }
    last_name { "lastname" }
    gender { [:f, :m].sample }
    country { ['country 1', 'country 2', 'country 3'].sample }
    city { ['city 1','city 2','city 3'].sample }
    date_of_birth { rand(18..90).year.ago }
  end
end
