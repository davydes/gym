require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'when create' do
    it 'should create a new instance given a valid attribute' do
      expect{ create(:user) }.to change { User.count }.by(1)
    end

    describe 'should be invalid with' do
      it 'empty name' do
        user = build(:user, :name => '')
        expect(user).to be_invalid
      end
      it 'long name' do
        user = build(:user, :name => 'a'*100)
        expect(user).to be_invalid
      end
      it 'wrong name format' do
        user = build(:user, :name => 'user#')
        expect(user).to be_invalid
      end
      it 'empty email' do
        user = build(:user, :email => '')
        expect(user).to be_invalid
      end
      it 'long email' do
        user = build(:user, :email => "#{'a'*100}@example.org")
        expect(user).to be_invalid
      end
      it 'wrong email format' do
        user1 = build(:user, :email => 'user@example')
        user2 = build(:user, :email => 'userexample.org')
        expect(user1).to be_invalid
        expect(user2).to be_invalid
      end
      it 'short password' do
        user = build(:user, :password => '12345', :password_confirmation => '12345')
        expect(user).to be_invalid
      end
      it 'too long password' do
        user = build(:user, :password => '12345'*10, :password_confirmation => '12345'*10)
        expect(user).to be_invalid
      end
      it 'not matched password_confirmation' do
        user = build(:user, :password_confirmation => '')
        expect(user).to be_invalid
      end
      it 'duplicate name' do
        user1 = create(:user)
        user2 = build(:user, :name => user1.name)
        expect(user2).to be_invalid
      end
      it 'duplicate email' do
        user1 = create(:user)
        user2 = build(:user, :email => user1.email)
        expect(user2).to be_invalid
      end
      it 'wrong first_name format' do
        user = build(:user, :first_name => 'Wrong@Name' )
        expect(user).to be_invalid
      end
      it 'too long first_name' do
        user = build(:user, :first_name => 'N'*51 )
        expect(user).to be_invalid
      end
      it 'wrong last_name format' do
        user = build(:user, :last_name => 'Wrong@Name' )
        expect(user).to be_invalid
      end
      it 'too long last_name' do
        user = build(:user, :last_name => 'N'*51 )
        expect(user).to be_invalid
      end
      it 'gender invalid value' do
        user = build(:user, :gender => 'i')
        expect(user).to be_invalid
      end
      it 'age least 18' do
        user = build(:user, :date_of_birth => 5.years.ago)
        expect(user).to be_invalid
      end
    end

    describe 'should be valid with' do
      it 'undefined first_name and last_name' do
        user = build(:user, :first_name => nil, :last_name =>  nil)
        expect(user).to be_valid
      end
      it 'undefined age' do
        user = build(:user, :date_of_birth => nil)
        expect(user).to be_valid
      end
      it 'undefined gender' do
        user = build(:user, :gender => nil)
        expect(user).to be_valid
      end
    end
  end

  describe 'when find_for_oauth' do
    it 'find existing user by identity' do
      user1 = create(:user)
      identity1 = create(:identity, user: user1)
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
      user2 = User.find_for_oauth (Utils::OAuth.normalize omniauth_hash)
      expect(user1.id).to be == user2.id
    end

    it 'find existing user by email' do
      user1 = create(:user)
      omniauth_hash = { 'provider' => 'provider_example',
                        'uid' => '12345',
                        'info' => {
                            'name' => 'example',
                            'email' => user1.email,
                            'nickname' => 'example'
                        },
                        'credentials' => {
                            'token' => Digest::SHA1.hexdigest([Time.now, rand].join),
                            'refresh_token' => Digest::SHA1.hexdigest([Time.now, rand].join)
                        }
      }
      user2 = User.find_for_oauth (Utils::OAuth.normalize omniauth_hash)
      expect(user1.id).to be == user2.id
    end

    it 'link identity to signed in user' do
      user1 = create(:user)
      omniauth_hash = { 'provider' => 'provider_example',
                        'uid' => '12345',
                        'info' => {
                            'name' => 'example',
                            'email' => 'example@ex.com',
                            'nickname' => 'example'
                        },
                        'credentials' => {
                            'token' => Digest::SHA1.hexdigest([Time.now, rand].join),
                            'refresh_token' => Digest::SHA1.hexdigest([Time.now, rand].join)
                        }
      }

      expect{
        User.find_for_oauth(Utils::OAuth.normalize(omniauth_hash), user1)
      }.to change { Identity.count }.by(1)
      expect(user1.identities.first.provider).to be == 'provider_example'
      expect(user1.identities.first.uid).to be == '12345'
    end
  end
end
