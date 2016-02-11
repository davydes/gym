class PictureSerializer < ActiveModel::Serializer

  attributes :id, :name, :description, :url

  def url
    object.image_url
  end

end