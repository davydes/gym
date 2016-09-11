class CreateProfiles < ActiveRecord::Migration
  def up
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :gender, limit: 1
      t.string :country
      t.string :city
      t.datetime :date_of_birth

      t.timestamps null: false
    end

    User.all.each do |u|
      say "Create profile for #{u.id}:#{u.email}"
      Profile.create do |p|
        p.user = u
        p.first_name    = u.first_name
        p.last_name     = u.last_name
        p.gender        = u.gender
        p.country       = u.country
        p.city          = u.city
        p.date_of_birth = u.date_of_birth
      end
    end

    remove_columns :users, :first_name, :last_name, :gender, :country, :city, :date_of_birth
  end

  def down    
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string, limit: 1
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :date_of_birth, :datetime

    Profile.all.each do |p|
      u = p.user
      say "Move values back for #{u.id}:#{u.email}"
      u.first_name = p.first_name
      u.last_name = p.last_name
      u.gender = p.gender
      u.country = p.country
      u.city = p.city
      u.date_of_birth = p.date_of_birth
      u.save
    end

    drop_table :profiles
  end
end
