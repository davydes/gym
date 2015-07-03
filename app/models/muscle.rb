class Muscle < ActiveRecord::Base
  include Anatomic

  serialize :shape, Muscles::Shape
  validates_inclusion_of :shape, in: Muscles::Shape.values
end
