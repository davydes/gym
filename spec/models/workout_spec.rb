require 'rails_helper'
RSpec.describe Workout, type: :model do
  let (:workout) { create :workout }

  describe 'ordering items' do
    describe 'should have asc ordering' do
      it 'when created in random order' do
        create :workout_item, workout: workout, exercise: create(:exercise), pos: 4
        create :workout_item, workout: workout, exercise: create(:exercise), pos: 2
        create :workout_item, workout: workout, exercise: create(:exercise), pos: 3
        create :workout_item, workout: workout, exercise: create(:exercise), pos: 1
        expect(workout.items.map(&:pos)).to be == (1..4).to_a
      end
    end
  end
end
