class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date     :payday,     null: false
      t.integer  :amount,     null: false
      t.integer  :kind,       null: false, default: 0
      t.datetime :started_at, null: false
      t.datetime :ended_at,   null: false
      t.text     :message
      t.text     :note

      t.timestamps null: false
    end
  end
end
