class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
