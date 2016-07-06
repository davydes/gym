class References::ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :name, :alias, :description

  has_many :muscles, serializer: MuscleShortSerializer
  has_many :body_parts, serializer: BodyPartShortSerializer
end