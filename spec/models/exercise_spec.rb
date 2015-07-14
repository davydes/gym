require 'rails_helper'

RSpec.describe Exercise, type: :model do
  it_behaves_like 'anatomic'

  it 'should create muscle' do
    expect { create(:exercise_with_muscle) }.to change{Muscle.count}.by(1)
  end

  it 'should create body_part' do
    expect { create(:exercise_with_body_part) }.to change{BodyPart.count}.by(1)
  end
end
