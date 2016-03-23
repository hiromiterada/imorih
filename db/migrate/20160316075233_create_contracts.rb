class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.references :user,           null: false, index: true, foreign_key: true
      t.string     :number,         null: false
      t.integer    :kind,           null: false, default: 0
      t.integer    :status,         null: false, default: 0
      t.integer    :rent,           null: false, default: 0
      t.date       :date_signed
      t.date       :date_terminated
      t.boolean    :auto_updating,  null: false, default: true
      t.text       :note

      t.timestamps null: false
    end
    add_index :contracts, :kind
    add_index :contracts, :status
    add_index :contracts, :auto_updating
  end
end
