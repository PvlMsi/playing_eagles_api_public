20.times do |i|
  User.create(
    email: "user#{i}@gmail.com",
    password: "password#{i}",
    password_confirmation: "password#{i}",
    city: 'Wrocław',
    street: [
      'Jedności Narodowej',
      'Nowowiejska',
      'Słowiańska',
      'Kromera'
    ].sample,
    first_name: Faker::Name.male_first_name,
    last_name: Faker::Name.last_name
  )
end

20.times do |i|
  Pitch.create(
    city: 'Wrocław',
    address: Faker::Address.street_address,
    opening_hour: 8,
    closing_hour: 22
  )
end

3.times do |i|
  User.first.games.create(
    pitch: Pitch.last,
    date: "2019-01-27 #{12 + i* 2}:00".to_time,
    time_length: 90,
    players_quantity: 7
  )
end

User.last.scheduled_events.create(
  pitch: Pitch.last,
  first_date: '2019-01-20'.to_date,
  last_date: '2019-04-28'.to_date,
  starting_hour: '9:00',
  finishing_hour: '11:00',
  interval: 1,
  interval_type: 1,
  description: 'Trening druzyny MKS Wrocław'
)

# 14.times do |i|
#   User.create(
#     email: "user#{i}@gmail.com",
#     password: "password#{i}",
#     password_confirmation: "password#{i}",
#     city: 'Wrocław',
#     street: [
#       'Jedności Narodowej',
#       'Nowowiejska',
#       'Słowiańska',
#       'Kromera'
#     ].sample
#   )
# end

# ['Bema 13', 'Jedności Nardowej 6'].each do |address|
#   Pitch.where(
#     city: 'Wrocław',
#     address: address,
#     opening_hour: 6,
#     closing_hour: 22
#   ).first_or_create!
# end

# User.first(5).each_with_index do |user, i|
#   Pitch.all.each_with_index do |pitch, j|
#     game = user.games.create(
#       pitch: pitch,
#       date: Time.current + i.days + j.days,
#       players_quantity: 7,
#       time_length: 90,
#       user: user
#     )
#     game.players.first.sign_me(user.id)
#     r = rand(13)
#     game.players.where(user: nil).first(r).zip(User.where.not(id: user.id).first(r)).each do |player, u|
#       player.sign_me(u.id)
#     end
#   end
# end
