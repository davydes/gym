class Journal::ItemSerializer < ActiveModel::Serializer
  attributes :id, :executed_at, :workout_attributes

  def executed_at
    object.executed_at.to_i
  end

  def workout_attributes
    ActiveModelSerializers::SerializableResource.new(object.workout)
  end
end
