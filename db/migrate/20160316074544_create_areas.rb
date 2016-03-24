class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.references :parking,        null: false, index: true, foreign_key: true
      t.string     :name,           null: false
      t.integer    :status,         null: false
      t.text       :note

      t.timestamps null: false
    end
  end
end
