class PictureUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png tiff tif)
  end

  process convert: 'jpg'
  process resize_to_limit: [2000, 2000]

  version :small do
    process resize_to_limit: [300, 300]
    process convert: 'jpg'
  end

  version :thumb, from_version: :small do
    process resize_to_fill: [150, 150]
    process convert: 'jpg'
  end

  def md5
    @md5 ||= Digest::MD5.hexdigest model.send(mounted_as).read.to_s
  end

  def filename
    @name ||= "#{model.imageable.class.name.downcase}_#{model.imageable.id}.jpg" if super
  end

end
