json.data do
  json.partial! 'v1/games/game', game: @game

  json.players do
    json.first_team do
      json.array! @game.players.first(@game.players_quantity) do |player|
        json.id player.id
        json.user_id player.user.present? ? player.user.id : ''
        json.name player.user.present? ? player.fullname : ''
        json.position player.position
      end
    end
    json.second_team do
      json.array! @game.players.last(@game.players_quantity) do |player|
        json.id player.id
        json.user_id player.user.present? ? player.user.id : ''
        json.name player.user.present? ? player.fullname : ''
        json.position player.position
      end
    end
  end
end