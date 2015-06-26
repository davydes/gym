class User < ActiveRecord::Base

  # validations

  # REGEX
  REAL_NAME_REGEX = /\A[\da-zа-яё ,.'\-_]*\z/i

  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates_length_of :email, maximum: 100
  validates_length_of :city, maximum: 100
  validates_length_of :country, maximum: 100

  validates :name, presence: true, format: { with: /\A\w*\z/i },
            length: { maximum: 50 },
            uniqueness: { case_sensitive: false }

  validates :first_name, format: { with: REAL_NAME_REGEX }, length: { maximum: 50 }
  validates :last_name,  format: { with: REAL_NAME_REGEX }, length: { maximum: 50 }
  validates :gender, inclusion: [:m, :f, 'm', 'f', nil]
  validate :at_least_18

  #callbacks

  before_save {
    self.email = email.downcase if email
    self.name = name.downcase if name
  }

  # associations

  has_many :identities, :dependent => :delete_all

  #methods

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session["devise.auth_data"])
        data = Utils::OAuth.normalize data
        user.email = data.info.email if user.email.blank?
        user.name = data.info.nickname
      end
    end
  end

  def self.find_for_oauth(normalized_auth, signed_in_user = nil)
    identity = Identity.find_for_oauth normalized_auth
    user = identity.user || signed_in_user || User.find_by_email(identity.email)

    if user.nil?
      generated_password = Devise.friendly_token.first(8)
      user = User.new(
          email: identity.email,
          confirmed_at: DateTime.now,
          name: identity.nickname,
          first_name: normalized_auth.info.first_name,
          last_name: normalized_auth.info.last_name,
          password: (generated_password),
          password_confirmation: (generated_password)
      )
      user.skip_confirmation!
      user.save!
      if user.persisted?
        puts 'Send welcome email to: '+user.email
        UserMailer.welcome(user, generated_password).deliver
      end
    end



    if identity.user != user
      identity.user = user
      identity.save!
    end

    user
  end

  private

  def at_least_18
    if self.date_of_birth
      errors.add(:date_of_birth, I18n.t('users.error.too_young')) if self.date_of_birth > 18.years.ago
    end
  end
end
