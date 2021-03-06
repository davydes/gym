class References::Muscle < ActiveRecord::Base
  include Anatomic

  has_and_belongs_to_many :body_parts
  has_and_belongs_to_many :exercises

  serialize :shape, Muscles::Shape
  validates_inclusion_of :shape, in: Muscles::Shape.values

  scope :no_bodypart, -> {
      where('id NOT IN (SELECT DISTINCT(muscle_id) FROM references_body_parts_muscles)')
  }

  has_many :picture_links, as: :pictureable, dependent: :destroy
  has_many :pictures, through: :picture_links
end
