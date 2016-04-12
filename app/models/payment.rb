class Payment < ActiveRecord::Base

  validates :contract_id, presence: true
  validates :payday, presence: true
  validates :amount, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  }

  belongs_to :contract

  scope :by_user, -> (user) {
    where(contract_id: user.contracts.pluck(:id))
  }
  scope :by_master, -> (user) {
    where(contract_id: Contract.by_master(user).pluck(:id))
  }
  scope :payday_limit, -> { where(payday: PAYDAY_LIMIT..Date.today) }

  PAYDAY_LIMIT = Date.today - 2.years

  def pay_later?
    payday >= date_started
  end

  def user
    contract.user
  end
end
