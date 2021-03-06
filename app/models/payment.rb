class Payment < ActiveRecord::Base
  include BooleanI18n

  before_validation :set_date_ended

  validates :contract_id, presence: true
  validates :payday, presence: true
  validates :amount, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  }
  validates :date_started, presence: true
  validates :date_ended, presence: true
  validate :start_end_check

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
    return if contract.blank?
    contract.user
  end

  def owner
    return if contract.blank?
    contract.owner
  end

  private

  def set_date_ended
    self.date_ended = date_ended.end_of_month
  end

  def start_end_check
    if self.date_started > self.date_ended
      errors.add(:date_ended,
        I18n.t('views.messages.greater_than',
          date: Payment.human_attribute_name(:date_started)))
    end
  end

end
