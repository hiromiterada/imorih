class Payment < ActiveRecord::Base
  validates :contract_id, presence: true
  validates :payday, presence: true
  validates :amount, numericality: :only_integer

  belongs_to :contract

  scope :by_user, -> (user) {
    where(contract_id: user.contracts.pluck(:id))
  }
end
