FactoryBot.define do
  factory :player do
    user { association(:user) }
    game { association(:game) }
    position { Faker::Number.between(0, 2) }
  end
end
