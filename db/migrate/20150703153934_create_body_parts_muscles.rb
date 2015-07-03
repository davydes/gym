class CreateBodyPartsMuscles < ActiveRecord::Migration
  def change
    create_table :body_parts_muscles, :id => false do |t|
      t.references :body_part, index: true, foreign_key: true
      t.references :muscle, index: true, foreign_key: true
    end
  end
end