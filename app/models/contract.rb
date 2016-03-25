class Contract < ActiveRecord::Base
  include BooleanI18n
  include EnumI18n
  include MakeRand

  before_validation :set_number

  validates :user_id, presence: true
  validates :owner_id, presence: true
  validates :parking_id, presence: true, if: :about_parking?
  validates :kind, presence: true
  validates :status, presence: true
  validates :number, presence: true, uniqueness: true
  validates :rent, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  }
  validates :areas, presence: true, if: :about_parking?

  belongs_to :user
  belongs_to :parking
  belongs_to :owner
  has_many :payments do
    def newest
      order('date_ended').last
    end
  end
  has_many :contract_areas
  has_many :areas, :through => :contract_areas

  enum kind: %i(leased_land monthly_parking)
  enum status: %i(pending in_process completed canceled)

  def about_parking?
    kind == 'monthly_parking'
  end

  def overdue?
    return if payments.blank?
    Date.today > payments.newest.date_ended
  end

  private

  def set_number
    return if !new_record? && number.present?
    self.user = User.create_without_confirmation if user.blank?
    retry_counter = 0
    begin
      if about_parking?
        area_code = [areas.first.name.upcase]
        (3 - area_code.length).times do
          area_code.unshift('0')
        end
        area_code = area_code.join
        parking_code = parking.code
      else
        area_code = '000'
        parking_code = '0000'
      end
      self.number = [
        kind[0].upcase + area_code,
        parking_code,
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
