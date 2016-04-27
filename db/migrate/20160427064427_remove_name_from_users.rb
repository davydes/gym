class RemoveNameFromUsers < ActiveRecord::Migration
  def change
    remove_index :users, column: :name, unique: true
    remove_column :users, :name, :string
  end
end
