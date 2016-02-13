require 'validators/file_size_validator'

class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  mount_uploader :image, PictureUploader

  validates :name, presence: true

  validates :image,
    presence: true,
    file_size: {
      maximum: 0.5.megabytes.to_i
    }

end