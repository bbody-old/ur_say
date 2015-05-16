json.array!(@polls) do |poll|
  json.extract! poll, :id, :user_id, :user_id, :question, :subtext
  json.url poll_url(poll, format: :json)
end
