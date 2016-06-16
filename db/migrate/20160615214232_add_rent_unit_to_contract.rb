class AddRentUnitToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :rent_unit, :integer, default: 1, null: false
  end
end
