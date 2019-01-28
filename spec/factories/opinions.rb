FactoryBot.define do
  factory :opinion do
    player { association(:player) }
    game { association(:game) }
    description { Faker::SiliconValley.quote }
    anonymous { Faker::Boolean.boolean(0.2) }
    nice_rate { Faker::Number.between(1, 5) }
    attitute_rate { Faker::Number.between(1, 5) }
    showed_up { Faker::Boolean.boolean(0.8) }
  end
end
