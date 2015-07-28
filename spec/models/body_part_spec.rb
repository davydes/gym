require 'rails_helper'

RSpec.describe BodyPart, type: :model do
  it_behaves_like 'anatomic'

  it 'should create muscle' do
    expect { create(:body_part_with_muscle) }.to change{Muscle.count}.by(1)
  end

  it 'should create exercise' do
    expect { create(:body_part_with_exercise) }.to change{Exercise.count}.by(1)
  end
end