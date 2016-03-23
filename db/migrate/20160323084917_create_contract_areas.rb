class CreateContractAreas < ActiveRecord::Migration
  def change
    create_table :contract_areas do |t|
      t.references :contract, index: true, foreign_key: true, null: false
      t.references :area,     index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
