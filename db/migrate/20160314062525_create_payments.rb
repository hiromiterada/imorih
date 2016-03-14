class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :payday
      t.integer :amount
      t.integer :kind
      t.text :message
      t.text :note

      t.timestamps null: false
    end
  end
end
