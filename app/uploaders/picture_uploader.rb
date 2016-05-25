class PictureUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay
  include CarrierWave::MiniMagick

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png tif tiff)
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

  def filename
    if original_filename.present?
      if model.respond_to?("#{mounted_as}_processing") && model.send("#{mounted_as}_processing")
        @name ||= model.send("#{mounted_as}_identifier")
      else
        @name ||= "#{secure_token(8)}.jpg"
      end
    end
  end

  protected

  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end
end