class App.Views.Shared.NotFound extends App.View
  template: HandlebarsTemplates['shared/not_found']

  render: ->
    @$el.html @template
    return @