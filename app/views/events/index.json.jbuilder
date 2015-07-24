json.array!(@events) do |event|
  json.extract! event, :id, :title, :starts_at, :place_id, :description
  json.url event_url(event, format: :json)
end
