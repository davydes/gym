require 'validators/time_range_validator'

class Journal::Item < ActiveRecord::Base
  belongs_to :journal
  belongs_to :workout

  validates :journal, :workout, :executed_at, presence: true
  validates :executed_at, time_range: { maximum: Time.now }
end
