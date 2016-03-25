json.array!(@owners) do |owner|
  json.extract! owner, :id, :name, :email, :address, :phone
  json.url owner_url(owner, format: :json)
end
