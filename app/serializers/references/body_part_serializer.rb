class References::BodyPartSerializer < ActiveModel::Serializer
  attributes :id, :name, :alias, :description

  has_many :muscles, serializer: References::MuscleShortSerializer
  has_many :exercises, serializer: References::ExerciseShortSerializer
end