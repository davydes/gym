class AddNameToProfiles < ActiveRecord::Migration

  class Profile < ActiveRecord::Base
    belongs_to :user
    validates :name, presence: true

    def init_name!
      name = user.email.gsub(/@.*/, '').gsub(/[^a-z0-9]/i,'_')
      if Profile.find_by_name(name)
        name_ = name
        1.step do |i|
          name = "#{name_}_#{i}"
          exit unless Profile.find_by_name(name)
        end
      end
      update!(name: name)
    end
  end

  def change
    add_column :profiles, :name, :string
    add_index :profiles, :name, unique: true

    reversible do |dir|
      dir.up do
        Profile.all.each(&:init_name!)
        say Profile.all.pluck(:name)
        change_column :profiles, :name, :string, null: false
      end
    end
  end
end
