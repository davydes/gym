class Workout::Item < ActiveRecord::Base
  belongs_to :workout
  belongs_to :exercise
  serialize :sets, Hash
end