require 'rails_helper'

RSpec.describe References::EquipmentJoin, type: :model do
  let (:equipment) { create :equipment }
  let (:equipmentable) { create :exercise }

  describe 'validation:' do
    it { expect(References::EquipmentJoin.create equipment: equipment, equipmentable: equipmentable).to be_valid }

    describe 'should be invalid' do
      it 'with duplicate PrimaryKey' do
        References::EquipmentJoin.create equipment: equipment, equipmentable: equipmentable
        expect(References::EquipmentJoin.create equipment: equipment, equipmentable: equipmentable).to be_invalid
      end
    end
  end
end
