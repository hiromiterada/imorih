class ContractArea < ActiveRecord::Base
  belongs_to :contract
  belongs_to :area
end
