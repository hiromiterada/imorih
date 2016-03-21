class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer  :contract_id, null: false
      t.date     :payday,      null: false
      t.integer  :amount,      null: false
      t.date     :date_started
      t.date     :date_ended
      t.text     :message
      t.text     :note

      t.timestamps null: false
    end
    add_index :payments, :contract_id
  end
end
