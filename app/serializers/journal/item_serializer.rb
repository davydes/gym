class Journal::ItemSerializer < ActiveModel::Serializer
  attributes :id, :executed_at
  belongs_to :workout

  def executed_at
    object.executed_at.to_i
  end
end
