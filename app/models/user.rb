class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  include EnumI18n

  enum locale: %i(ja en)
  enum gender: %i(male female)
  enum role: %i(normal owner admin)

  def fullname
    lastname.to_s + ' ' + firstname.to_s
  end
end
