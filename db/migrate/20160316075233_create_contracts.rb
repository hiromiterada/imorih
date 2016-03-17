class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer  :user_id
      t.string   :number,             null: false
      t.integer  :kind,               null: false, default: 0
      t.integer  :rent,               null: false
      t.datetime :contracted_at
      t.datetime :termed_at
      t.boolean  :automatic_updating, null: false, default: true
      t.text     :note

      t.timestamps null: false
    end
    add_index :contracts, :user_id
    add_index :contracts, :kind
    add_index :contracts, :automatic_updating
  end
end