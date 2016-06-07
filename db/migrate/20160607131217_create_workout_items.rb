class CreateWorkoutItems < ActiveRecord::Migration
  def change
    create_table :workout_items do |t|
      t.references :workout, foreign_key: true, null: false
      t.references :exercise, foreign_key: true, null: false
      t.text :description
      t.text :sets, null: false
      t.integer :pos, null: false
    end
    add_index :workout_items, [:workout_id, :pos], :unique => true
  end
end
