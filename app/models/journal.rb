class Journal < ActiveRecord::Base
  belongs_to :user
  has_many :items, ->  { order(executed_at: :desc) },
           class_name: 'Journal::Item',
           dependent: :destroy

  validates :user, presence: true
end
