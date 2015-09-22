json.array!(@arcanas) do |arcana|
  json.extract! arcana, :id, :name
  json.url arcana_url(arcana, format: :json)
end
