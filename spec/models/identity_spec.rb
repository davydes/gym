require 'rails_helper'

RSpec.describe Identity, :type => :model do
  describe 'when create' do
    it 'should create a new instance given a valid attribute' do
      expect{ create(:identity) }.to change { Identity.count }.by(1)
    end

    describe 'should be invalid with' do
      it 'duplicate' do
        identity1 = create(:identity)
        identity2 = build(:identity, :provider => identity1.provider, :uid => identity1.uid)
        expect(identity2).to be_invalid
      end
    end
  end

  describe 'when find_for_oauth' do
    it 'should find exists identity by provider&uid' do
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

    it 'should create new identity' do
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
