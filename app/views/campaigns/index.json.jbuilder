json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :name, :subject, :from_name, :from_email, :sent_at
  json.url campaign_url(campaign, format: :json)
end
