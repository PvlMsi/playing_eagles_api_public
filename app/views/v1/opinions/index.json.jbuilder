json.array! @opinions do |opinion|
  json.partial! 'opinion', opinion: opinion
end