class MuscleSerializer < ActiveModel::Serializer
  attributes :id, :name, :alias, :description, :shape
  has_many :exercises, include: false, embed: :id
  has_many :body_parts, include: false, embed: :id
end
