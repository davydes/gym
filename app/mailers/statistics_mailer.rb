class StatisticsMailer < ApplicationMailer
  def common
    @stats = {
      users: User.count,
      body_parts: BodyPart.count,
      exercises: Exercise.count,
      muscles: Muscle.count,
      workouts: Workout.count,
      workout_items: Workout::Item.count,
      jounal_items: Journal::Item.count
    }
    mail(to: User.all.where(admin: true).map(&:email), subject: 'Common Stats')
  end
end
