class Profile < ActiveRecord::Base
  belongs_to :user, required: true
  
  REAL_NAME_REGEX = /\A[\da-zа-яё ,.'\-_]*\z/i
  validates :first_name, :last_name, format: { with: REAL_NAME_REGEX }, length: { maximum: 50 }
  validates :gender, inclusion: [:m, :f, 'm', 'f', nil]
  validates :city, :country, length: { maximum: 100 }
  validate :at_least_18

  private

  def at_least_18
    if self.date_of_birth
      errors.add(:date_of_birth, I18n.t('users.error.too_young')) if self.date_of_birth >= 18.years.ago
    end
  end
end
