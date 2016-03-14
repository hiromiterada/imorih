class Payment < ActiveRecord::Base
  validates :payday, presence: true
  validates :amount, presence: true
  validates :kind, presence: true
  validates :started_at, presence: true
  validates :ended_at, presence: true
end
