FactoryGirl.define do
  factory :profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    location { Faker::Address.city }
    country { Faker::Address.country }
    about_me { Faker::Lorem.sentence }
  end
end
