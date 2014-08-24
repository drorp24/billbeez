json.array!(@dues) do |due|
  json.extract! due, :id
  json.url due_url(due, format: :json)
end
