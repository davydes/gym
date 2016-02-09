class PictureSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :imageable_id, :imageable_type
end