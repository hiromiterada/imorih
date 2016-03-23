class Contract < ActiveRecord::Base
  include BooleanI18n
  include EnumI18n
  include MakeRand

  before_validation :set_number

  validates :kind, presence: true
  validates :status, presence: true
  validates :number, presence: true, uniqueness: true

  belongs_to :user
  has_many :payments
  has_many :contract_areas
  has_many :areas, :through => :contract_areas

  enum kind: %i(leased_land monthly_parking)
  enum status: %i(pending in_process completed canceled)

  def set_number
    self.user = User.create_without_confirmation if user.blank?
    retry_counter = 0
    begin
      self.number = [
        kind[0].upcase + '000',
        '0000',
        make_rand_string(4),
        user.customer_code[0,4],
        user.customer_code[4,4]
      ].join('-')
      raise if Contract.where(number: number).first.present?
    rescue
      retry_counter += 1
      if retry_counter <= 10
        retry
      else
        logger.info 'Retried 10 times so go to next loop.'
        raise
      end
    end
  end
end
