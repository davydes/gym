class RenameScopedReferences < ActiveRecord::Migration
  def change
    rename_table 'body_parts', 'references_body_parts'
    rename_table 'body_parts_exercises', 'references_body_parts_exercises'
    rename_table 'body_parts_muscles', 'references_body_parts_muscles'
    rename_table 'exercises', 'references_exercises'
    rename_table 'exercises_muscles', 'references_exercises_muscles'
    rename_table 'muscles', 'references_muscles'
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE picture_links
             SET pictureable_type = 'References::Muscle'
           WHERE pictureable_type = 'Muscle'
        SQL
      end
      dir.down do
        execute <<-SQL
          UPDATE picture_links
             SET pictureable_type = 'Muscle'
           WHERE pictureable_type = 'References::Muscle'
        SQL
      end
    end
  end
end
