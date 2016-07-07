class References::MuscleSerializer < ActiveModel::Serializer
  attributes :id, :name, :alias, :description, :shape

  has_many :exercises, serializer: References::ExerciseShortSerializer
  has_many :body_parts, serializer: References::BodyPartShortSerializer
  has_many :pictures
end