class CreateBodyParts < ActiveRecord::Migration
  def change
    create_table :body_parts do |t|
      t.string :alias, null: false
      t.string :name, null: false
      t.text   :description
    end

    add_index :body_parts, :alias, unique: true
  end
end