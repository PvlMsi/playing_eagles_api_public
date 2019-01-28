FactoryBot.define do
  factory :game do
    association :pitch, factory: :pitch
    date { Faker::Date.forward(30) }
    players_quantity { Faker::Number.between(5, 7) }
    time_length { Faker::Number.between(45, 90) }
    user { association(:user) }
  end
end
