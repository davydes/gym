class App.Views.Journals.Items.Show extends App.CompositeView
  template: HandlebarsTemplates['journals/items/show']

  initialize: (options) ->
    @listenTo @model, "change", @render

  params: ->
    executed_at: moment.unix(@model.get('executed_at')).format('YYYY.MM.DD HH:MM')

  render: ->
    @$el.html @template @params()
    @appendChildTo(new App.Views.Workouts.Show({ model: @model.workout }), @$('.workout'))
    return @