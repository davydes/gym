class CreateWorkoutItems < ActiveRecord::Migration
  def change
    create_table :workout_items do |t|
      t.belongs_to :workout, index: true, foreign_key: true, null: false
      t.belongs_to :exercise, index: true, foreign_key: true, null: false
      t.text :description
      t.text :sets, null: false
      t.integer :pos, null: false

      t.timestamps null: false
    end
    add_index :workout_items, [:workout_id, :pos], :unique => true
  end
end
