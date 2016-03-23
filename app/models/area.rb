class Area < ActiveRecord::Base
  belongs_to :parking
  has_many :contract_areas
  has_many :contracts, :through => :contract_areas
end
