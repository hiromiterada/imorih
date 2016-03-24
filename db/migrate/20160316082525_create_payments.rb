class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :contract,    null: false, index: true, foreign_key: true
      t.date       :payday,      null: false
      t.integer    :amount,      null: false, default: 0
      t.date       :date_started
      t.date       :date_ended
      t.text       :message
      t.text       :note

      t.timestamps null: false
    end
  end
end
