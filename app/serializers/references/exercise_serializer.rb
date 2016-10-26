class References::ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :name, :alias, :description

  has_many :equipments
  has_many :muscles, serializer: References::MuscleShortSerializer
  has_many :body_parts, serializer: References::BodyPartShortSerializer
end