class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :alias, null: false
      t.string :name, null: false
      t.text :description

      t.timestamps null: false
    end
  end
end
