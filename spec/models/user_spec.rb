require 'rails_helper'

RSpec.describe User, :type => :model do
  let (:user) { build :user }

  describe 'validation:' do

    describe 'should be valid' do
      it 'by default' do
        expect(user).to be_valid
      end

      context 'when attribute' do
        it ' first_name and last_name is undefined' do
          user.first_name = user.last_name = nil
          expect(user).to be_valid
        end

        it 'age is undefined' do
          user.date_of_birth = nil
          expect(user).to be_valid
        end

        it 'gender is undefined' do
          user.gender = nil
          expect(user).to be_valid
        end
      end
    end

    describe 'should be invalid' do
      context 'when attribute' do
        describe :name do
          it 'is empty' do
            user.name = ''
            expect(user).to be_invalid
          end

          it 'too long' do
            user.name = 'a'*100
            expect(user).to be_invalid
          end

          it 'has wrong format' do
            user.name = 'user#'
            expect(user).to be_invalid
          end

          it 'already exists' do
            user.name = create(:user).name
            expect(user).to be_invalid
          end
        end

        describe :email do
          it 'is empty' do
            user.email = ''
            expect(user).to be_invalid
          end

          it 'too long' do
            user.email = "#{'a'*100}@example.org"
            expect(user).to be_invalid
          end

          it 'has wrong format' do
            user.email = 'user@example'
            expect(user).to be_invalid
            user.email = 'userexample.org'
            expect(user).to be_invalid
          end

          it 'already exists' do
            user.email = create(:user).email
            expect(user).to be_invalid
          end
        end

        describe :password do
          it 'too short' do
            user = build(:user, :password => '12345', :password_confirmation => '12345')
            expect(user).to be_invalid
          end

          it 'too long' do
            user = build(:user, :password => '12345'*10, :password_confirmation => '12345'*10)
            expect(user).to be_invalid
          end

          it 'not matched with password_confirmation' do
            user = build(:user, :password_confirmation => '')
            expect(user).to be_invalid
          end
        end

        describe :first_name do
          it 'has wrong format' do
            user.first_name = 'Wrong@Name'
            expect(user).to be_invalid
          end

          it 'too long' do
            user.first_name = 'N'*51
            expect(user).to be_invalid
          end
        end

        describe :last_name do
          it 'has wrong format' do
            user.last_name = 'Wrong@Name'
            expect(user).to be_invalid
          end

          it 'too long' do
            user.last_name = 'N'*51
            expect(user).to be_invalid
          end
        end

        it 'gender has invalid value' do
          user = build(:user, :gender => 'i')
          expect(user).to be_invalid
        end

        it 'age least 18' do
          user = build(:user, :date_of_birth => 5.years.ago)
          expect(user).to be_invalid
        end
      end
    end
  end

  describe '::find_for_oauth' do
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
