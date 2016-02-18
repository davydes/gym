require 'rails_helper'

RSpec.describe PictureLink, type: :model do
  describe '.create' do
    it 'should valid' do
      pl = PictureLink.create(picture: create(:picture), pictureable: create(:muscle))
      expect(pl).to be_valid
    end
  end
end