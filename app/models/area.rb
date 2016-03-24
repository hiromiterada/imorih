class Area < ActiveRecord::Base
  include EnumI18n

  belongs_to :parking
  has_many :contract_areas
  has_many :contracts, :through => :contract_areas

  validates :name, presence: true,
    uniqueness: { scope: [:parking_id] },
    format: { with: /\A[a-z0-9]+\z/i,
      message: I18n.t('activerecord.errors.messages.onebyte_alphanumeric_only')}
  validates :status, presence: true

  scope :actives, -> { where(status: 'available') }

  enum status: %i(available unavailable)
end
