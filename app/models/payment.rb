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

  def pay_later?
    payday >= date_started
  end
end
