json.id event.id
json.type event.model_name.name
if event.model_name.name == 'Game'
  json.time_from event.date.strftime('%H:%M')
  json.time_to (event.date + event.time_length.minutes).strftime('%H:%M')
  json.event_url v1_game_path(event)[3..-1]
  json.description "Gra #{event.id}"
else
  json.time_from event.starting_hour.strftime('%H:%M')
  json.time_to event.finishing_hour.strftime('%H:%M')
  json.description event.description
  json.event_url v1_scheduled_event_path(event)[3..-1]
end