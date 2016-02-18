class PictureLink < ActiveRecord::Base
  self.primary_keys = :pictureable_id, :pictureable_type, :picture_id

  belongs_to :picture
  belongs_to :pictureable, polymorphic: true

  validates_uniqueness_of :picture_id, scope: [:pictureable_id, :pictureable_type]
end
