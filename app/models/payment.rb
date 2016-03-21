class Payment < ActiveRecord::Base
  validates :contract_id, presence: true
  validates :payday, presence: true
  validates :amount, presence: true

  belongs_to :contract

  scope :search_user, -> (user) {
    where(contract_id: user.contracts.pluck(:id))
  }
end
