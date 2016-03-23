json.array!(@managements) do |management|
  json.extract! management, :id, :name, :email, :address, :phone
  json.url management_url(management, format: :json)
end
