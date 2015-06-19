class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string, limit: 1
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :date_of_birth, :datetime
    add_index :users, :name, unique: true
  end
end
