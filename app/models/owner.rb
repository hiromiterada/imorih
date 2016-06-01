class Owner < ActiveRecord::Base

  validates :name, presence: true
  validates :email, presence: true

  has_many :parkings
  has_many :contracts
  has_many :owner_users
  has_many :users, through: :owner_users
  accepts_nested_attributes_for :owner_users, allow_destroy: true,
    reject_if: proc { |attributes| attributes['user_id'].blank? }
end
