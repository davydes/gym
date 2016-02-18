require 'rails_helper'

RSpec.describe Identity, :type => :model do
  let (:identity) {build :identity}

  describe 'validation' do
    it { expect(identity).to be_valid }

    describe 'should be invalid' do
      it 'when attribute pair [provider, uid] already exists' do
        identity_ = create(:identity)
        identity.provider, identity.uid = identity_.provider, identity_.uid
        expect(identity).to be_invalid
      end
    end
  end

  describe '::find_for_oauth' do
    it 'when find exists identity by provider&uid' do
      identity1 = create(:identity, email: 'example@ex.com')
      omniauth_hash = { 'provider' => identity1.provider,
                        'uid' => identity1.uid,
                        'info' => {
                            'name' => 'example',
                            'email' => identity1.email,
                            'nickname' => 'example'
                        },
                        'credentials' => {
                            'token' => Digest::SHA1.hexdigest([Time.now, rand].join),
                            'refresh_token' => Digest::SHA1.hexdigest([Time.now, rand].join)
                        }
      }
      identity2 = Identity.find_for_oauth Utils::OAuth.normalize(omniauth_hash)
      expect(identity1.id).to be == identity2.id
    end

    it 'when create new identity' do
      identity1 = create(:identity, email: 'example@ex.com')
      omniauth_hash = { 'provider' => identity1.provider,
                        'uid' => identity1.uid+rand(5..10).to_s,
                        'info' => {
                            'name' => 'example',
                            'email' => identity1.email,
                            'nickname' => 'example'
                        },
                        'credentials' => {
                            'token' => Digest::SHA1.hexdigest([Time.now, rand].join),
                            'refresh_token' => Digest::SHA1.hexdigest([Time.now, rand].join)
                        }
      }
      identity2 = Identity.find_for_oauth Utils::OAuth.normalize(omniauth_hash)
      expect(identity1.id).not_to be == identity2.id
    end
  end
end
