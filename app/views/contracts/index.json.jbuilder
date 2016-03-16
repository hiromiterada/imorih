json.array!(@contracts) do |contract|
  json.extract! contract, :id, :user_id, :number, :kind, :rent, :started_at, :ended_at
  json.url contract_url(contract, format: :json)
end
