class Workout::ItemSerializer < ActiveModel::Serializer
  attributes :pos, :sets, :exercise_id
end
