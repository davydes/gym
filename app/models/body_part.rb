class BodyPart < ActiveRecord::Base
  include Anatomic

  has_and_belongs_to_many :muscles
end
