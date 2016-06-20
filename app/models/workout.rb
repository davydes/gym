class Workout < ActiveRecord::Base
  belongs_to  :workoutable, polymorphic: true
  has_many :items, -> { order(:pos) }, :class_name => 'Workout::Item', autosave: true, validate: true

  validates :name, presence: true, length: { maximum: 250 }
  validates :description, length: { maximum: 8000 }
end
