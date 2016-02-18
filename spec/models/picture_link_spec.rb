require 'rails_helper'

RSpec.describe PictureLink, type: :model do
  let (:picture) { create :picture }
  let (:pictureable) { create :muscle }

  describe 'validation:' do
    it { expect(PictureLink.create picture: picture, pictureable: pictureable).to be_valid }

    describe 'should be invalid' do
      it 'with duplicate PrimaryKey' do
        PictureLink.create picture: picture, pictureable: pictureable
        expect(PictureLink.create picture: picture, pictureable: pictureable).to be_invalid
      end
    end
  end
end
