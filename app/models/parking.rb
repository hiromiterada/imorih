class Parking < ActiveRecord::Base
  include MakeRand

  before_validation :set_code

  validates :owner_id, presence: true
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :canonical_name, presence: true, uniqueness: true

  belongs_to :owner
  has_many :contracts
  has_many :areas, dependent: :destroy
  accepts_nested_attributes_for :areas, allow_destroy: true,
    reject_if: proc { |attributes| attributes['name'].blank? }

  scope :by_master, -> (user) {
    where(owner_id: user.owners.pluck(:id))
  }

  def set_code
    retry_counter = 0
    begin
      self.code = make_rand_string(4)
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
end
