module ApplicationHelper
  def auth_provider_to_css(provider)
    case provider.to_s
      when 'vkontakte'
        return 'vk';
      else
        return provider.to_s
    end
  end

  def get_href(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}
    html_options = convert_options_to_data_attributes(options, html_options)
    url = url_for(options)
    html_options['href'] ||= url
  end

  def menu_link_to(name = nil, options = nil, html_options = nil, &block)
    link = get_href name, options, html_options, &block
    content_tag :li, class: ('active' if current_page?(link)) do
      link_to name, options, html_options, &block
    end
  end
end