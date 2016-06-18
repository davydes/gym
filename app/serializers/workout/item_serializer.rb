class Workout::ItemSerializer < ActiveModel::Serializer
  attributes :id, :pos, :sets, :exercise_id
end
