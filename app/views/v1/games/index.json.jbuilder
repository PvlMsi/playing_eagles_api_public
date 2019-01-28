json.data do
  json.array! @games do |game|
    json.partial! 'v1/games/game', game: game
  end
end