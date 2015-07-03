class CreateMuscles < ActiveRecord::Migration
  def change
    create_table :muscles do |t|
      t.string :alias, null: false
      t.string :name, null: false
      t.text   :description
      t.string :shape

      t.timestamps null: false
    end
    add_index :muscles, :alias, unique: true
  end
end
