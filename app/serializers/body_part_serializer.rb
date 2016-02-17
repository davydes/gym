class BodyPartSerializer < ActiveModel::Serializer
  attributes :id, :name, :alias, :description

  has_many :muscles, serializer: MuscleShortSerializer
  has_many :exercises, serializer: ExerciseShortSerializer
end