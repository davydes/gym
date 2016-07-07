class Workout::Item < ActiveRecord::Base
  belongs_to :workout
  belongs_to :exercise, class_name: 'References::Exercise'

  serialize :sets, Array

  validates :exercise, :sets, :pos, presence: true
  validates :pos, numericality: { only_integer: true, greater_than: 0 },
                  uniqueness: { scope: :workout }
end