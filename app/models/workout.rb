class Workout < ActiveRecord::Base
  include Anatomic

  has_many :items, -> { order(:pos) }, :class_name => 'Workout::Item'
end