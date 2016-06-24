require 'validators/time_range_validator'

class Journal::Item < ActiveRecord::Base
  belongs_to :journal
  has_one    :workout,
             as: :workoutable,
             autosave: true,
             validate: true,
             dependent: :destroy
  accepts_nested_attributes_for :workout

  validates :journal, :workout, :executed_at, presence: true
  validates :executed_at, time_range: { maximum: -> { Time.now } }
end
