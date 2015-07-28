require 'rails_helper'

RSpec.describe Muscle, type: :model do
  it_behaves_like 'anatomic'

  describe 'when save' do
    it 'should be valid with right shape' do
      Muscles::Shape.values.each do |shape|
        muscle = build(:muscle, shape: shape)
        expect(muscle).to be_valid
      end
    end

    it 'should be invalid with nil shape' do
      muscle = build(:muscle, shape: nil)
      expect(muscle).to be_invalid
      expect(muscle.errors[:shape].size).to be > 0
    end

    it 'should raise ArgumentError with wrong shape' do
      expect {
        muscle = build(:muscle, shape: 'non-existing shape')
      }.to raise_error(ArgumentError)
    end

    it 'should create body_part' do
      expect { create(:muscle_with_body_part) }.to change{BodyPart.count}.by(1)
    end

    it 'should create exercise' do
      expect { create(:muscle_with_exercise) }.to change{Exercise.count}.by(1)
    end
  end
end