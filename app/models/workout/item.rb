class Workout::Item < ActiveRecord::Base
  belongs_to :workout
  belongs_to :exercise

  validates :workout, :exercise, :sets, :pos, presence: true

  serialize :sets, Hash

  validates :pos, numericality: { only_integer: true, greater_than: 0 },
                  uniqueness: { scope: :workout }
end
