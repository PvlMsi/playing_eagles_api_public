json.data do
  json.array! @games do |game|
    json.call(
      game,
      :id
    )
    json.date game.date.strftime('%d.%m.%Y %H:%M')
    json.pitch do
      json.partial! 'v1/pitches/pitch', pitch: game.pitch
    end
    json.position game.players.where(user: @user).first.position
  end
end