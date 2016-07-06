class References::MuscleSerializer < ActiveModel::Serializer
  attributes :id, :name, :alias, :description, :shape

  has_many :exercises, serializer: ExerciseShortSerializer
  has_many :body_parts, serializer: BodyPartShortSerializer
  has_many :pictures
end