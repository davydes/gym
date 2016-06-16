class App.Views.Workouts.Show extends App.CompositeView
  template: HandlebarsTemplates['workouts/show']

  params: ->
    @model.toJSON()

  render: ->
    @$el.html @template @params()
    return @