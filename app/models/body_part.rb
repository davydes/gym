class BodyPart < ActiveRecord::Base
  include Anatomic

  has_and_belongs_to_many :muscles
  has_and_belongs_to_many :exercises

  scope :with_muscles, -> {
      joins(:muscles).
      group('body_parts.id').
      having('count(body_part_id) > 0')
  }
end
