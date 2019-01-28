json.call(
  opinion,
  :id,
  :description,
  :anonymous,
  :fair_play_rate,
  :would_recommend_rate
)

json.game_url v1_game_path(opinion.player.game)
json.issuing_user_id !!opinion.issuing_user ? opinion.issuing_user.id : nil
json.issuing_user_name !!opinion.issuing_user ? opinion.issuing_user.fullname : nil
json.issuing_user_url !!opinion.issuing_user ? v1_game_path(opinion.issuing_user) : nil