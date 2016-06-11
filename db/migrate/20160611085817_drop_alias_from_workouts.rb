class DropAliasFromWorkouts < ActiveRecord::Migration
  def change
    remove_column :workouts, :alias
  end
end
