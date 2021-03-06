class Identity < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(normalized_auth)
    auth = normalized_auth
    identity = find_or_create_by(provider: auth.provider, uid: auth.uid)
    identity.accesstoken = auth.credentials.token
    identity.refreshtoken = auth.credentials.refresh_token
    identity.name = auth.info.nickname
    identity.email = auth.info.email
    identity.nickname = auth.info.nickname
    identity.image = auth.info.image
    identity.phone = auth.info.phone
    identity.urls = (auth.info.urls || "").to_json
    identity.save
    identity
  end
end
