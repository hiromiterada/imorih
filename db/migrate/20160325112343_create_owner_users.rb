class CreateOwnerUsers < ActiveRecord::Migration
  def change
    create_table :owner_users do |t|
      t.references :owner, index: true, foreign_key: true, null: false
      t.references :user,  index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
