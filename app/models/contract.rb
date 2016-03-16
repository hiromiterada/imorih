class Contract < ActiveRecord::Base
  include BooleanI18n
  include EnumI18n
  include MakeRand

  before_validation :set_number

  validates :kind, presence: true
  validates :number, presence: true
  validates :rent, presence: true
  validates :number, presence: true, uniqueness: true

  belongs_to :user
  has_many :payments

  enum kind: %i(leasedland monthlyparking dailyparking)

  def set_number
    self.user = User.create_without_confirmation if user.blank?
    retry_counter = 0
    begin
      self.number = [
        kind[0].upcase + '000',
        '0000',
        make_rand_integer(4),
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
