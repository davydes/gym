class CreateExercisesMuscles < ActiveRecord::Migration
  def change
    create_table :exercises_muscles, :id => false do |t|
      t.references :exercise, index: true, foreign_key: true
      t.references :muscle, index: true, foreign_key: true
    end
  end
end
