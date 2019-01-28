json.array! @pitches do |pitch|
  json.partial! 'pitch', pitch: pitch
end