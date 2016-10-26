class CreateReferencesEquipmentJoins < ActiveRecord::Migration
  def change
    create_table :references_equipment_joins, id: false do |t|
      t.references :equipment, index: true
      t.references :equipmentable, polymorphic: true
      t.foreign_key :references_equipment, column: :equipment_id
    end
    add_index :references_equipment_joins, [:equipmentable_id, :equipmentable_type, :equipment_id], name: 'pk_references_equipment_joins', unique: true
  end
end
