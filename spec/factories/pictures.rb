FactoryGirl.define do
  factory :picture do
    name 'Test Picture'
    description 'Test Picture'
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'pictures', 'test_image.jpg')) }
  end

end
