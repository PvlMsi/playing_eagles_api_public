FactoryBot.define do
  factory :scheduled_event do
    pitch { association(:pitch) }
    date_from { Faker::Date.between(Date.today, 1.week.from_now) }
    date_to { Faker::Date.between(1.week.from_now, 1.year.from_now) }
    interval { Faker::Number.between(1, 10) } 
    interval_type { Faker::Number.between(0, 2) }
    canceled { false }
  end
end
