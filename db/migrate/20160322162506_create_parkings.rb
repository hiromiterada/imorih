class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.references :management,     null: false, index: true, foreign_key: true
      t.string     :name,           null: false
      t.string     :code,           null: false
      t.string     :canonical_name, null: false
      t.string     :address
      t.float      :latitude
      t.float      :longitude
      t.text       :description
      t.text       :price
      t.text       :message
      t.text       :cautions

      t.timestamps null: false
    end
    add_index :parkings, :code, unique: true
    add_index :parkings, :canonical_name, unique: true
  end
end
