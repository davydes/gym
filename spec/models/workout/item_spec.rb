require 'rails_helper'
RSpec.describe Workout::Item, type: :model do
  let (:workout) { create :workout }
  let (:exercise) { create :exercise }
  let (:item) { build :workout_item, workout: workout, exercise: exercise }

  describe 'validation' do
    it { expect(item).to be_valid }

    describe 'should be invalid' do
      describe 'when attribute' do
        context 'exercise' do
          it 'is nil' do
            item.exercise = nil
            expect(item).to_not be_valid
          end
        end

        context 'sets' do
          it 'is nil' do
            item.sets = nil
            expect(item).to_not be_valid
          end

          it 'has wrong type' do
            expect{ item.sets = 'string value' }.to raise_error ActiveRecord::SerializationTypeMismatch
          end
        end

        context 'pos' do
          it 'is nil' do
            item.pos = nil
            expect(item).not_to be_valid
          end

          it 'less than 1' do
            item.pos = 0
            expect(item).not_to be_valid
          end

          it 'has wrong value' do
            item.pos = 'val'
            expect(item).not_to be_valid
          end

          it 'has exists value in workout scope' do
            item.pos = 1
            create :workout_item, workout: workout, exercise: exercise, pos: item.pos
            expect(item).not_to be_valid
          end
        end
      end
    end
  end
end
