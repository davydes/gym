module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count)

    html = <<-HTML
    <div class="panel panel-danger">
      <div class="panel-heading">
        #{sentence}
        <a class="pull-right btn btn-danger btn-xs" role="button" data-toggle="collapse" href="#error_explanation" aria-expanded="false" aria-controls="error_explanation">
          <span class="glyphicon glyphicon-collapse-down"></span>
        </a>
      </div>
      <div class="panel-body collapse" id="error_explanation">
        <ul>#{messages}</ul>
      </div>
    </div>
    HTML

    html.html_safe
  end
end
