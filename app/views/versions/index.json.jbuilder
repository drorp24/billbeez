json.array!(@versions) do |version|
  json.extract! version, :id, :header_external, :header_external_link
  json.url version_url(version, format: :json)
end
