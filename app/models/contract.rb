class Contract < ActiveRecord::Base
  include BooleanI18n
  include EnumI18n
  include MakeRand

  before_validation :set_code

  validates :user_id, presence: true
  validates :owner_id, presence: true
  validates :parking_id, presence: true, if: :about_parking?
  validates :kind, presence: true
  validates :status, presence: true
  validates :code, presence: true, uniqueness: true
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
  has_many :areas, through: :contract_areas

  enum kind: %i(leased_land monthly_parking)
  enum status: %i(pending in_process completed canceled)

  scope :by_master, -> (user) {
    where(owner_id: user.owners.pluck(:id))
  }

  def about_parking?
    kind == 'monthly_parking'
  end

  def overdue?
    return if payments.blank?
    Date.today > payments.newest.date_ended
  end

  private

  def set_code
    return if !new_record? || user.blank? || code.present?
    retry_counter = 0
    begin
      if about_parking?
        area_code = [areas.first.name.upcase]
        (2 - area_code.length).times do
          area_code.unshift('0')
        end
        area_code = area_code.join
        parking_code = parking.code
      else
        area_code = '00'
        parking_code = '000'
      end
      self.code = [
        kind[0].upcase + parking_code[1,3],
        area_code + user.customer_code[0,2].upcase,
        user.customer_code[2,4],
        make_rand_string(4)
      ].join('-')
      raise if Contract.where(code: code).first.present?
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
