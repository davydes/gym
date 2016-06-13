class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :name, :items

  def items
    ActiveModel::SerializableResource.new(object.items)
  end
end
