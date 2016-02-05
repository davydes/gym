class ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :name, :alias, :description
  has_many :muscles, include: false, embed: :id
  has_many :body_parts, include: false, embed: :id
end