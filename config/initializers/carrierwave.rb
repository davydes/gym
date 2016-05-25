CarrierWave.configure do |config|

  # Disable processing in tests
  if  Rails.env.test? || Rails.env.cucumber?
    config.enable_processing = false
  end

  if Rails.env.development? || Rails.env.test? || Rails.env.cucumber?
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