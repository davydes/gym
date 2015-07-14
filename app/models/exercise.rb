class Exercise < ActiveRecord::Base
  include Anatomic

  has_and_belongs_to_many :body_parts
  has_and_belongs_to_many :muscles
end
