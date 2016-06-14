class Workout::Item < ActiveRecord::Base
  belongs_to :workout
  belongs_to :exercise

  serialize :sets, Array

  validates :workout, :exercise, :sets, :pos, presence: true
  validates :pos, numericality: { only_integer: true, greater_than: 0 },
                  uniqueness: { scope: :workout }
end
