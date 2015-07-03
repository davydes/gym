module Anatomic
  extend ActiveSupport::Concern

  included do

    # Validations

    validates :alias, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[_a-z0-9]*\z/i }
    validates :name, presence: true, length: { maximum: 250 }
    validates :description, length: { maximum: 8000 }

    # Callbacks
    before_save { |anatomic| anatomic.alias = anatomic.alias.downcase }

  end
end