json.array!(@parkings) do |parking|
  json.extract! parking, :id, :owner_id, :name, :code, :address, :latitude, :longitude, :description, :price, :message, :cautions
  json.url parking_url(parking, format: :json)
end
