class Workout < ActiveRecord::Base
  has_many :items, -> { order(:pos) }, :class_name => 'Workout::Item'

  validates :name, presence: true, length: { maximum: 250 }
  validates :description, length: { maximum: 8000 }
end
