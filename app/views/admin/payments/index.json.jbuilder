json.array!(@payments) do |payment|
  json.extract! payment, :id, :payday, :amount, :kind, :message, :note
  json.url payment_url(payment, format: :json)
end
