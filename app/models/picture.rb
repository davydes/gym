class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  mount_uploader :image, PictureUploader

  validates :name, presence: true
end
