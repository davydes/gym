class References::BodyPart < ActiveRecord::Base
  include Anatomic

  has_and_belongs_to_many :muscles
  has_and_belongs_to_many :exercises

  scope :with_muscles, -> {
    includes(:muscles).where.not(references_muscles: { id: nil })
  }
end
