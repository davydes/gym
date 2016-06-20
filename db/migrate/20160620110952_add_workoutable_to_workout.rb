class AddWorkoutableToWorkout < ActiveRecord::Migration
  def up
    change_table :workouts do |t|
      t.references :workoutable, polymorphic: true, index: true
    end

    Journal::Item.all.each do |item|
      Workout.connection.execute(
          "UPDATE workouts " +
          "  SET workoutable_type = 'Journal::Item', workoutable_id = #{item.id} " +
          "  WHERE id = #{item.workout_id}"
      )
    end

    change_table :journal_items do |t|
      t.remove_references :workout, index: true, foreign_key: true, null: false
    end
  end

  def down
    change_table :journal_items do |t|
      t.references :workout, index: true, foreign_key: true
    end

    Workout.all.each do |workout|
      Journal::Item.connection.execute(
          "UPDATE journal_items " +
          "  SET workout_id = '#{workout.id}' " +
          "  WHERE 'Journal::Item' = '#{workout.workoutable_type}' and id = '#{workout.workoutable_id}'"
      )
    end

    change_column_null :journal_items, :workout_id, false

    change_table :workouts do |t|
      t.remove_references :workoutable, polymorphic: true, index: true
    end
  end
end
