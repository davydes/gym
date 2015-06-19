class User < ActiveRecord::Base

  # validations

  # REGEX
  REAL_NAME_REGEX = /\A[\da-zа-яё ,.'\-_]*\z/i
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  validates :name, presence: true, format: { with: /\A\w{3,}\z/i },
            length: { maximum: 50 },
            uniqueness: { case_sensitive: false }

  validates :email,
            presence: true,
            length: { maximum: 100 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates :first_name, format: { with: REAL_NAME_REGEX }, length: { maximum: 50 }
  validates :last_name,  format: { with: REAL_NAME_REGEX }, length: { maximum: 50 }
  validates :gender, inclusion: [:m, :f, 'm', 'f', nil]
  validate :at_least_18

  #callbacks

  before_save {
    self.email = email.downcase
    self.name = name.downcase
  }

  # associations

  has_many :identities

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  #methods

  def self.find_for_oauth(auth, signed_in_resource = nil)

    identity = Identity.find_for_oauth(auth)

    # todo: clean zombie accounts
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.screen_name,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  private

  def at_least_18
    if self.date_of_birth
      errors.add(:date_of_birth, I18n.t('users.error.too_young')) if self.date_of_birth > 18.years.ago
    end
  end
end
