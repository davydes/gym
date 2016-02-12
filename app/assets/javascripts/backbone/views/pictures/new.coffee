class App.Views.Pictures.New extends App.View
  template: HandlebarsTemplates['pictures/new']
  id: 'pictures'

  events:
    'click a' : 'index'

  render: ->
    @$el.html @template
    return @
