require 'validators/file_size_validator'
require 'validators/file_mime_type_validator'

class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  mount_uploader :image, PictureUploader

  validates :name, presence: true

  validates :image,
    presence: true,
    file_size: { maximum: 1.megabytes.to_i },
    file_mime_type: { content_type: /image/ }

end