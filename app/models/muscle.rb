class Muscle < ActiveRecord::Base
  include Anatomic

  has_and_belongs_to_many :body_parts

  serialize :shape, Muscles::Shape
  validates_inclusion_of :shape, in: Muscles::Shape.values
end
