require 'rails_helper'
RSpec.describe Workout::Item, type: :model do
  let (:workout) { create :workout }
  let (:exercise) { create :exercise }
  let (:item) { build :workout_item, workout: workout, exercise: exercise }

  describe 'validation' do
    it { expect(item).to be_valid }
  end
end