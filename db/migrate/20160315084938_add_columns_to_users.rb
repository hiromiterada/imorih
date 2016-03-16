class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lastname,      :string
    add_column :users, :firstname,     :string
    add_column :users, :locale,        :integer, null: false, default: 0
    add_column :users, :gender,        :integer, null: false, default: 0
    add_column :users, :birthday,      :date
    add_column :users, :address,       :string
    add_column :users, :phone,         :string
    add_column :users, :role,          :integer, null: false, default: 0
    add_column :users, :customer_code, :string,  null: false
    add_column :users, :send_of_dm,    :boolean, null: false, default: true

    add_index :users, :role
    add_index :users, :send_of_dm
  end
end
