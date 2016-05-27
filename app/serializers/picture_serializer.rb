class PictureSerializer < ActiveModel::Serializer

  attributes :id, :name, :description, :url, :thumb, :image_processing

  def url
    object.image_url
  end

  def thumb
    object.image_url(:thumb)
  end

end