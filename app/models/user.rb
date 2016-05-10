class User < ActiveRecord::Base
  include BooleanI18n
  include EnumI18n
  include MakeRand

  attr_accessor :login

  before_validation :set_customer_code

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  validates :customer_code, presence: true, uniqueness: true

  has_many :contracts, -> { order('date_signed') }
  has_many :owner_users
  has_many :owners, through: :owner_users

  enum locale: %i(ja en)
  enum gender: %i(male female)
  enum role: %i(normal master admin)

  DUMMY_DOMAINNAME = '@example.com'

  def send_mail?
    return false unless send_of_dm
    email =~ /#{DUMMY_DOMAINNAME}$/ ? false : true
  end

  def set_customer_code
    return if customer_code.present?
    retry_counter = 0
    begin
      self.customer_code = make_rand_integer(8)
      raise if User.where(customer_code: customer_code).first.present?
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

  def set_password
    self.password = make_rand_string(8).downcase.gsub(/(l|1|q|9|o|0)/, 'h')
  end

  class << self
    def create_without_confirmation(options={})
      user = User.new
      if options[:customer_code].present?
        user.customer_code = options[:customer_code]
      else
        user.set_customer_code 
      end
      code = user.customer_code.downcase
      if options[:email].present?
        user.email = options[:email]
      else
        user.email = code + DUMMY_DOMAINNAME
      end
      if options[:password].present?
        user.password = options[:password]
      else
        user.set_password
      end
      if options[:role].present?
        user.role = options[:role]
      end
      user.skip_confirmation!
      user.save!
      user
    end

    def find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where([
          "customer_code = :value OR lower(email) = lower(:value)",
          { :value => login }
        ]).first
      else
        where(conditions).first
      end
    end
  end
end
