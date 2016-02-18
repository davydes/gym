require 'rails_helper'

RSpec.describe Picture, type: :model do
  describe 'validation:' do
    let (:picture) do
      build(:picture)
    end

    it { expect(picture).to be_valid }

    describe 'should be invalid' do
      context 'when attribute' do
        it 'name is empty' do
          picture.name = ''
          expect(picture).to be_invalid
          expect(picture.errors.messages.keys).to eq([:name])
        end

        describe :image do
          it 'is empty' do
            picture.remove_image!
            expect(picture).to be_invalid
            expect(picture.errors.messages.keys).to eq([:image])
          end

          it 'has wrong content type' do
            picture.image.file.content_type = 'wrong/type'
            expect(picture).to be_invalid
            expect(picture.errors.messages.keys).to eq([:image])
          end
        end
      end
    end
  end

  describe '::pictureables' do
    it 'should include pictureable' do
      pictureable = create :muscle, pictures: [picture = create(:picture)]
      expect(picture.pictureables).to include pictureable
    end
  end
end
