module Utils
  class OAuth
    def self.normalize ( data )
      data = OmniAuth::AuthHash.new(data) if data.kind_of? Hash
      # for example:
      # data.info.nickname = data.extra.raw_info.screen_name if (data.nickname.blank? && data.provider == 'vkontakte')
      data
    end
  end
end