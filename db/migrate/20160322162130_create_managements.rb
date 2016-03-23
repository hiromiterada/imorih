class CreateManagements < ActiveRecord::Migration
  def change
    create_table :managements do |t|
      t.string :name
      t.string :email, null: false
      t.string :address
      t.string :phone

      t.timestamps null: false
    end
  end
end
