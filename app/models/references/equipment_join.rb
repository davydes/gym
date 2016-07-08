class References::EquipmentJoin < ActiveRecord::Base
  self.primary_keys = :equipmentable_id, :equipmentable_type, :equipment_id

  belongs_to :equipment, :class_name => 'References::Equipment'
  belongs_to :equipmentable, polymorphic: true

  validates_uniqueness_of :equipment_id, scope: [:equipmentable_id, :equipmentable_type]
end