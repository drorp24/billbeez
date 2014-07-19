json.array!(@newsletters) do |newsletter|
  json.extract! newsletter, :id, :customer_id, :version_id, :sent_at, :finding_1
  json.url newsletter_url(newsletter, format: :json)
end
