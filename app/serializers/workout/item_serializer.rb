class Workout::ItemSerializer < ActiveModel::Serializer
  attributes :id, :pos, :sets
  belongs_to :exercise, serializer: ExerciseShortSerializer
end
