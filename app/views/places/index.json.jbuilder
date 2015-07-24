json.array!(@places) do |place|
  json.extract! place, :id, :place_name, :address
  json.url place_url(place, format: :json)
end
