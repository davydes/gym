module ApplicationHelper
  def auth_provider_to_css(provider)
    case provider.to_s
      when 'vkontakte'
        return 'vk';
      else
        return provider.to_s
    end
  end
end
