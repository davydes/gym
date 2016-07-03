class App.Views.Workouts.Show extends App.CompositeView
  template: HandlebarsTemplates['workouts/show']

  initialize: ->
    @itemsView = new App.Views.Workouts.Item()

  params: ->
    name: @model.get('name')

  renderLayout: ->
    @$el.html @template @params()

  renderItems: ->
    @model.items.each (item) =>
      @appendChildTo(new App.Views.Workouts.Item(model: item), @$('ul.items'))

  render: ->
    @renderLayout()
    @renderItems()
    return @