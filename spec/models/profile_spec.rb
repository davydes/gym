require 'rails_helper'

RSpec.describe Profile, type: :model do
  let (:object) { build :profile }

  describe 'callback' do
    describe 'name downcase!' do      
      it 'any name should be down case' do
        object.name = 'ABC'
        object.validate
        expect(object.name).to eq 'abc'
      end
    end

    describe ':default_name' do
      describe 'when save persisted model' do
        it 'should be invalid without name' do
          object.save!
          object.name = ''
          object.validate
          expect(object).to be_invalid
          expect(object.errors.messages.keys).to include :name
        end
      end

      describe 'when build new model' do
        it 'should be set default name unless defined' do
          object.name = ''
          object.validate
          expect(object.name).to be_present
        end

        it 'should be not set default name if defined' do
          name = 'test_name'
          object.name = name
          object.validate
          expect(object.name).to eq(name)
        end

        it 'should be increment number when name exists' do
          name_prefix = 'some_uniq_name'
          create :profile, name: "#{name_prefix}_1"
          user = create :user, email: "#{name_prefix}@testmail.org"
          object = create :profile, user: user
          expect(object.name).to eq "#{name_prefix}_2"
        end
      end
    end
  end

  describe 'validation:' do

    describe 'should be valid' do
      it 'by default' do
        expect(object).to be_valid
      end

      context 'when attribute' do
        it ' first_name and last_name is undefined' do
          object.first_name = object.last_name = nil
          expect(object).to be_valid
        end

        it 'age is undefined' do
          object.date_of_birth = nil
          expect(object).to be_valid
        end

        it 'gender is undefined' do
          object.gender = nil
          expect(object).to be_valid
        end
      end
    end
    
    describe 'should be invalid' do
      context 'when attribute' do
        describe :first_name do
          it 'has wrong format' do
            object.first_name = 'Wrong@Name'
            expect(object).to be_invalid
            expect(object.errors.messages.keys).to include :first_name
          end

          it 'too long' do
            object.first_name = 'N'*51
            expect(object).to be_invalid
            expect(object.errors.messages.keys).to include :first_name
          end
        end

        describe :last_name do
          it 'has wrong format' do
            object.last_name = 'Wrong@Name'
            expect(object).to be_invalid
            expect(object.errors.messages.keys).to include :last_name
          end

          it 'too long' do
            object.last_name = 'N'*51
            expect(object).to be_invalid
            expect(object.errors.messages.keys).to include :last_name
          end
        end

        it 'gender has invalid value' do
          object.gender = 'i'
          expect(object).to be_invalid
          expect(object.errors.messages.keys).to include :gender
        end

        it 'age least 18' do
          object.date_of_birth = 5.years.ago
          expect(object).to be_invalid
          expect(object.errors.messages.keys).to include :date_of_birth
        end
      end
    end
  end
end
