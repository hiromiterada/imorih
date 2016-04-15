class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :address
      t.string :phone
      t.string :representative
      t.text   :signature

      t.timestamps null: false
    end
  end
end
