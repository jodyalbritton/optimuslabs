json.array!(@rate_types) do |rate_type|
  json.extract! rate_type, :id, :name, :unit
  json.url rate_type_url(rate_type, format: :json)
end
