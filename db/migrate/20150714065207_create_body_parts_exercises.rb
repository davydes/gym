class CreateBodyPartsExercises < ActiveRecord::Migration
  def change
    create_table :body_parts_exercises, :id => false do |t|
      t.references :body_part, index: true, foreign_key: true
      t.references :exercise, index: true, foreign_key: true
    end
  end
end
