json.array!(@options) do |option|
  json.extract! option, :id, :poll_id, :title, :poll_id
  json.url option_url(option, format: :json)
end
