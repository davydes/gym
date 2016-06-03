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
        :provider                         => 'Google',
        :google_storage_access_key_id     => Rails.application.secrets.fog_accesskey,
        :google_storage_secret_access_key => Rails.application.secrets.fog_secretkey
    }
    config.fog_directory = Rails.application.secrets.fog_directory
  end

end