class Parking < ActiveRecord::Base
  include BooleanI18n
  include MakeRand
  include Geocode

  before_validation :set_code, :set_geocode

  validates :owner_id, presence: true
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true,
    length: { is: 4 }
  validates :canonical_name, presence: true, uniqueness: true

  belongs_to :owner
  has_many :contracts
  has_many :areas, dependent: :destroy
  accepts_nested_attributes_for :areas, allow_destroy: true,
    reject_if: proc { |attributes| attributes['name'].blank? }

  scope :by_master, -> (user) {
    where(owner_id: user.owners.pluck(:id))
  }
  scope :publics, -> { where(is_public: true) }

  # 収容台数
  def capacity
    areas.count
  end

  # 空き区画
  def vacancies
    areas.reject {|area| area.contracts.try(:in_process).present? }
  end

  private

  def set_code
    return if !new_record? && code.present?
    retry_counter = 0
    begin
      self.code = 'P' + make_rand_string(3)
      raise if Parking.where(code: code).first.present?
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

  def set_geocode
    return if address.blank?
    self.address_to_geocode_by_google_map
  end
end
