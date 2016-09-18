class Profile < ActiveRecord::Base
  belongs_to :user, required: true
  
  NAME_REGEX = /\A[0-9a-z_]*\z/
  REAL_NAME_REGEX = /\A[\da-zа-яё ,.'\-_]*\z/i
  validates :name,
    format: { with: NAME_REGEX }, length: { maximum: 20 },
    presence: true, uniqueness: true
  validates :first_name, :last_name,
    format: { with: REAL_NAME_REGEX }, length: { maximum: 50 }
  validates :gender, inclusion: [:m, :f, 'm', 'f', nil]
  validates :city, :country, length: { maximum: 100 }
  validate :at_least_18, if: -> { date_of_birth.present? }

  before_validation { self.name.try(:downcase!) }
  before_validation :default_name, if: -> { new_record? && name.blank? }

  def need_to_fill?
    name.blank?
  end

  def to_param
    name
  end

  private

  def default_name
    self.name = user.email.gsub(/@.*/, '').gsub(/[^a-z0-9]/i,'_')
    return true unless Profile.find_by_name(self.name)
    1.step do |i|
      name = "#{self.name}_#{i}"
      unless Profile.find_by_name(name)
        self.name = name
        return true
      end
    end
  end

  def at_least_18
    errors.add(:date_of_birth, :too_young) if self.date_of_birth >= 18.years.ago
  end
end
