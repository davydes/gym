class WorkoutSerializer < ActiveModel::Serializer
  attributes :name, :items_attributes

  def items_attributes
    ActiveModelSerializers::SerializableResource.new(object.items)
  end
end
