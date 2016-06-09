class Journal < ActiveRecord::Base
  belongs_to :user
  has_many :items, :class_name => 'Journal::Item'

  validates :user, presence: true
end
