json.array!(@plans) do |plan|
  json.extract! plan, :id, :supplier_id, :name
  json.url plan_url(plan, format: :json)
end
