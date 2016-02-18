class CreatePictureImageables < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        create_table :picture_links, id: false  do |t|
          t.references :picture, index: true, foreign_key: true
          t.references :pictureable, polymorphic: true
        end
        add_index :picture_links, [:pictureable_id, :pictureable_type, :picture_id], name: 'pk_picture_links', unique: true
        execute <<-SQL
          INSERT INTO picture_links (picture_id, pictureable_type, pictureable_id)
          SELECT id, imageable_type, imageable_id from pictures
        SQL

        remove_columns :pictures, :imageable_id, :imageable_type
      end
      dir.down do
        add_reference :pictures, :imageable, polymorphic: true, index: true
        execute <<-SQL
          UPDATE pictures
             SET imageable_id = (select picture_links.pictureable_id
                                   from picture_links
                                  where picture_links.picture_id = pictures.id),
                 imageable_type = (select picture_links.pictureable_type
                                     from picture_links
                                    where picture_links.picture_id = pictures.id)
           WHERE EXISTS(
             SELECT *
               FROM picture_links
              WHERE picture_links.picture_id = pictures.id
           )
        SQL
        remove_foreign_key :pk_picture_links, :picture
        remove_index(:picture_links, :name => 'pk_picture_links')
        drop_table :picture_links
      end
    end
  end
end
