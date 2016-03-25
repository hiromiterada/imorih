json.array!(@contracts) do |contract|
  json.extract! contract, :id, :user_id, :owner_id, :number, :kind, :status, :rent, :date_signed, :date_terminated, :auto_updating, :note
  json.url contract_url(contract, format: :json)
end
