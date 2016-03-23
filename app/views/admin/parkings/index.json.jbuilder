json.array!(@parkings) do |parking|
  json.extract! parking, :id, :management_id, :name, :code, :address, :latitude, :longitude, :description, :price, :message, :cautions
  json.url parking_url(parking, format: :json)
end
