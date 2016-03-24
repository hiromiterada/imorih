class Management < ActiveRecord::Base

  validates :name, presence: true
  validates :email, presence: true

  has_many :parkings
end
