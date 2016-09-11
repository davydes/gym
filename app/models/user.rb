class User < ActiveRecord::Base

  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :email, length: { maximum: 100 }

  #callbacks

  before_save {
    self.email = email.downcase if email
  }

  after_create :create_profile

  # associations

  has_many :identities, :dependent => :delete_all
  has_one  :journal, dependent: :destroy
  has_one  :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  #methods
  
  # создаем журнал, если не создан
  alias :original_journal_method :journal
  def journal
    if original_journal_method.nil? 
      Rails.logger.warn "Create journal for user_id #{self.id}"
      Journal.create(user: self)
    else
      original_journal_method
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session["devise.auth_data"])
        data = Utils::OAuth.normalize data
        user.email = data.info.email if user.email.blank?
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
          password: generated_password,
          password_confirmation: generated_password
      )
      user.skip_confirmation!
      user.save!
      user.profile.update_attributes(
        first_name: normalized_auth.info.first_name,
        last_name: normalized_auth.info.last_name 
      )
      UserMailer.delay.welcome(user.id, generated_password) if user.persisted?
    end

    if user.persisted? && identity.user != user
      identity.user = user
      identity.save!
    end

    user
  end

  private

  def create_profile
    Profile.create(user: self) unless profile
  end
end
