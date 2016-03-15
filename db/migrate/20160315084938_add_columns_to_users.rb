class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lastname, :string
    add_column :users, :firstname, :string
    add_column :users, :locale, :integer, default: 0
    add_column :users, :gender, :integer, default: 0
    add_column :users, :birthday, :date
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :role, :integer, null: false, default: 0
    add_index :users, :role
  end
end
