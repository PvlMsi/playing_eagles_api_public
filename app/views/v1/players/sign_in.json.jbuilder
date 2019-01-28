json.data do
  json.call(
    @player,
    :id,
    :fullname,
    :user_id,
    :game_id,
    :position
  )
end