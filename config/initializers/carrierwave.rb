CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
    config.fog_credentials = {
        :provider                         => ENV['FOG_PROVIDER'],
        :google_storage_access_key_id     => ENV['FOG_ACCESSKEY'],
        :google_storage_secret_access_key => ENV['FOG_SECRETKEY']
    }
    config.fog_directory = ENV['FOG_DIRECTORY']
  end
end