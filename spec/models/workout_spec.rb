require 'rails_helper'
RSpec.describe Workout, type: :model do
  it_behaves_like 'anatomic'

  describe 'ordering items' do
    it 'should be right' do
      workout = create :workout
      create :workout_item, workout: workout, exercise: create(:exercise), pos: 4
      create :workout_item, workout: workout, exercise: create(:exercise), pos: 2
      create :workout_item, workout: workout, exercise: create(:exercise), pos: 3
      create :workout_item, workout: workout, exercise: create(:exercise), pos: 1

      expect(workout.items.map(&:pos)).to be == (1..4).to_a
    end
  end
end