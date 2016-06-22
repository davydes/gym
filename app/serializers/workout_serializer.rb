class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :name, :items

  def items
    ActiveModelSerializers::SerializableResource.new(object.items)
  end
end
