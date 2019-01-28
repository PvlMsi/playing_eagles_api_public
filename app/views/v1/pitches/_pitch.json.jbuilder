json.call(
  pitch,
  :id,
  :city,
  :address,
  :opening_hour,
  :closing_hour
)

json.url v1_pitch_path(pitch)[3..-1]