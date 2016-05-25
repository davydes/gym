require 'carrierwave/test/matchers'

describe PictureUploader do
  include CarrierWave::Test::Matchers

  let(:picture) { create(:picture, process_image_upload: true) }
  let(:uploader) { PictureUploader.new(picture, :image) }

  before do
    PictureUploader.enable_processing = true
  end

  after do
    PictureUploader.enable_processing = false
    uploader.remove!
  end

  describe '3000px image' do
    before do
      File.open(File.join(Rails.root, 'spec', 'support', 'pictures', '3000.png')) { |f| uploader.store!(f) }
    end

    describe 'the thumb version' do
      it "scales down/up image to be exactly 150 by 150 pixels" do
        expect(uploader.thumb).to have_dimensions(150, 150)
      end
    end

    describe 'the small version' do
      it "scales down image to fit within 300 by 300 pixels" do
        expect(uploader.small).to be_no_larger_than(300, 300)
      end
    end

    describe 'the original version' do
      it "scales down image to fit within 2000 by 2000 pixels" do
        expect(uploader).to be_no_larger_than(2000, 2000)
      end
    end
  end

  describe '1px image' do
    before do
      File.open(File.join(Rails.root, 'spec', 'support', 'pictures', 'test_image.jpg')) { |f| uploader.store!(f) }
    end

    describe 'the thumb version' do
      it "scales down/up image to be exactly 150 by 150 pixels" do
        expect(uploader.thumb).to have_dimensions(150, 150)
      end
    end

    describe 'the small version' do
      it "is 1 by 1 pixels" do
        expect(uploader.small).to have_dimensions(1, 1)
      end
    end

    describe 'the original version' do
      it "is 1 by 1 pixels" do
        expect(uploader).to have_dimensions(1, 1)
      end
    end
  end

  describe 'filename' do
    before do
      File.open(File.join(Rails.root, 'spec', 'support', 'pictures', 'test_image.jpg')) { |f| uploader.store!(f) }
    end

    it "has the correct file extension" do
      expect(uploader.file.extension.downcase).to eq('jpg')
    end

    it "has the correct file basename" do
      expect(uploader.file.basename.downcase).to match(/[0-9a-z]{8}/i)
    end
  end
end