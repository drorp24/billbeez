json.array!(@texts) do |text|
  json.extract! text, :id, :header_external, :header_external_link
  json.url text_url(text, format: :json)
end
