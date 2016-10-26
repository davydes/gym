class References::Exercise < ActiveRecord::Base
  include Anatomic

  has_and_belongs_to_many :body_parts
  has_and_belongs_to_many :muscles

  has_many :equipment_joins, :class_name => 'References::EquipmentJoin', as: :equipmentable
  has_many :equipments, :class_name => 'References::Equipment', through: :equipment_joins
end
