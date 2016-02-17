class WelcomeController < ApplicationController
  def index
    @user_count = User.count
    @muscle_count = Muscle.count
    @body_part_count = BodyPart.count
    @exercise_count = Exercise.count
  end
end
