require 'rails_helper'

RSpec.describe References::Muscle, type: :model do
  it_behaves_like 'anatomic'

  let (:muscle) { build :muscle }

  describe 'validation:' do
    describe 'should be valid' do
      context 'when attribute' do
        it 'shape is valid' do
          Muscles::Shape.values.each do |shape|
            muscle.shape = shape
            expect(muscle).to be_valid
          end
        end
      end
    end

    describe 'should be invalid' do
      context 'when attribute' do
        it 'shape is empty' do
          muscle.shape = nil
          expect(muscle).to be_invalid
          expect(muscle.errors.messages.keys).to eq [:shape]
        end
      end
    end
  end

  it 'should raise ArgumentError with wrong shape' do
    def build_resource
      build :muscle, shape: 'non-existing shape'
    end
    expect { build_resource }.to raise_error(ArgumentError)
  end

  it 'should create body_part' do
    expect { create(:muscle_with_body_part) }.to change{References::BodyPart.count}.by(1)
  end

  it 'should create exercise' do
    expect { create(:muscle_with_exercise) }.to change{References::Exercise.count}.by(1)
  end

end