class AddNameToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :name, :string
    add_index :profiles, :name, unique: true
  end
end
