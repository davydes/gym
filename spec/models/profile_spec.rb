RSpec.describe Profile, type: :model do
  let (:object) { build :profile }

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
          end

          it 'too long' do
            object.first_name = 'N'*51
            expect(object).to be_invalid
          end
        end

        describe :last_name do
          it 'has wrong format' do
            object.last_name = 'Wrong@Name'
            expect(object).to be_invalid
          end

          it 'too long' do
            object.last_name = 'N'*51
            expect(object).to be_invalid
          end
        end

        it 'gender has invalid value' do
          object.gender = 'i'
          expect(object).to be_invalid
        end

        it 'age least 18' do
          object.date_of_birth = 5.years.ago
          expect(object).to be_invalid
        end
      end
    end
  end
end
