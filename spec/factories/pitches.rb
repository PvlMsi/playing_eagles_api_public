FactoryBot.define do
  factory :pitch do
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    opening_hour { Faker::Number.between(6, 10) }
    closing_hour { Faker::Number.between(16, 22) }
  end
end
