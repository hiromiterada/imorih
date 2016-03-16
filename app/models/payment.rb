class Payment < ActiveRecord::Base
  validates :contract_id, presence: true
  validates :payday, presence: true
  validates :amount, presence: true
  validates :started_at, presence: true
  validates :ended_at, presence: true

  belongs_to :contract
end
