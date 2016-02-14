class PictureSerializer < ActiveModel::Serializer

  attributes :id, :name, :description, :url, :thumb

  def url
    object.image_url
  end

  def thumb
    object.image_url(:thumb)
  end

end