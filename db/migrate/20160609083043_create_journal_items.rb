class CreateJournalItems < ActiveRecord::Migration
  def change
    create_table :journal_items do |t|
      t.belongs_to :journal, index: true, foreign_key: true, null: false
      t.belongs_to :workout, index: true, foreign_key: true, null: false
      t.timestamp :executed_at, null: false

      t.timestamps null: false
    end
  end
end
