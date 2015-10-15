module DeviseHelper
  def admin?
    current_user and current_user.admin?
  end

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
          <i id="error_explanation_chevron" class="fa fa-chevron-down"></i>
        </a>
      </div>
      <div class="panel-body collapse" id="error_explanation">
        <ul>#{messages}</ul>
      </div>
    </div>

    <script>
      (function() {
        $('#error_explanation').on('shown.bs.collapse', function() {
          $("#error_explanation_chevron").addClass('fa-chevron-up').removeClass('fa-chevron-down');
        });

        $('#error_explanation').on('hidden.bs.collapse', function() {
          $("#error_explanation_chevron").addClass('fa-chevron-down').removeClass('fa-chevron-up');
        });
      }).call(this);
    </script>
    HTML

    html.html_safe
  end
end
