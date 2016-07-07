class App.Views.Workouts.Show extends App.CompositeView
  template: HandlebarsTemplates['workouts/show']

  params: ->
    name: @model.get('name')

  renderLayout: ->
    @$el.html @template @params()

  renderItems: ->
    @model.items.each (item) =>
      @appendChildTo(new App.Views.Workouts.Items.Item(model: item), @$('ol.items'))

  render: ->
    @renderLayout()
    @renderItems()
    return @