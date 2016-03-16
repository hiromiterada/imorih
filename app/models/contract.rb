class Contract < ActiveRecord::Base
  include EnumI18n

  validates :kind, presence: true
  validates :number, presence: true
  validates :rent, presence: true

  belongs_to :user
  has_many :payments

  enum kind: %i(leasedland monthlyparking dailyparking)
end
