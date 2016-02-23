require 'validators/file_size_validator'
require 'validators/file_mime_type_validator'

class Picture < ActiveRecord::Base
  scope :lonely, -> { where.not(:id => PictureLink.select(:picture_id).uniq) }

  has_many :picture_links, dependent: :destroy

  mount_uploader :image, PictureUploader

  validates :name, presence: true

  validates :image,
    presence: true,
    file_size: { maximum: 1.megabytes.to_i },
    file_mime_type: { content_type: /image/ }

  def pictureables
    picture_links.map {|x| x.pictureable}
  end

end