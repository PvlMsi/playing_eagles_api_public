json.call(
  game,
  :id,
  :time_length
)

json.date game.date.strftime('%d.%m.%Y %H:%M')

json.pitch do
  json.partial! 'v1/pitches/pitch', pitch: game.pitch
end

json.game_url v1_game_path(game)

json.seats_left do
  json.array! game.seats_left do |seat|
    json.id seat.id
    json.position seat.position
  end
end