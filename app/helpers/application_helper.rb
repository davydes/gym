module ApplicationHelper
  def auth_provider_to_css(provider)
    case provider.to_s
      when 'vkontakte'
        return 'vk';
      when 'google_oauth2'
        return 'google-plus';
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

  def index_of_model_path(model)
    send(model.class.to_s.underscore.tr('/','_').pluralize+'_path')
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true,
        tables: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def page_title
    title = content_for?(:title) ? yield(:title) : I18n.t(:sitename)
    title = '[DEVELOP] ' + title if Rails.env.development?
    title = '[STAGING] ' + title if Rails.env.staging?
    title
  end

  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    ActiveModelSerializers::SerializableResource.new(target, options).to_json
  end
end