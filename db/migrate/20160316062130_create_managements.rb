class CreateManagements < ActiveRecord::Migration
  def change
    create_table :managements do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :address
      t.string :phone

      t.timestamps null: false
    end
  end
end
