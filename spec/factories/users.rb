FactoryBot.define do
  factory :user do
    password { 'pass' }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birth_date { Faker::Date.birthday(16, 80) }
    phone_number { Faker::PhoneNumber.phone_number }
    city { Faker::Address.city }
    street { Faker::Address.street_name }
  end
end
