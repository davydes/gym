class App.Views.Profiles.Current extends App.View
  template: HandlebarsTemplates['profiles/current']

  params: ->
    name: @model.get('name')

  renderLayout: ->
    @$el.html @template @params()

  render: ->
    @renderLayout()
    return @
