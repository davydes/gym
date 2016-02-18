require 'rails_helper'

RSpec.describe Picture, type: :model do
  describe 'when save' do
    before (:each) do
      @picture = build(:picture)
    end

    it 'should be valid with right attributes' do
      expect(@picture).to be_valid
    end

    it 'should be invalid without name' do
      @picture.name = ''
      expect(@picture).to be_invalid
    end

    it 'should be invalid without image' do
      @picture.remove_image!
      expect(@picture).to be_invalid
    end

    it 'should be invalid with wrong content type' do
      @picture.image.file.content_type = 'wrong/type'
      expect(@picture).to be_invalid
    end

  end
end
