class App.Views.Shared.Components.ExerciseView extends App.View
  template: HandlebarsTemplates['shared/components/exercise_view']

  initialize: (options) ->
    unless App.reference_exercises?
      App.reference_exercises = new App.Collections.Exercise({}, { url: '/references/exercises' })
      App.reference_exercises.fetch()
    @collection = App.reference_exercises
    @listenTo(@collection, 'sync', @render)
    @exercise_id = options.exercise_id

  params: ->
    model = @collection.get(@exercise_id)
    if model?
      url: model.url()
      name: model.get('name')
    else
      name: 'unknow'

  renderLayout: ->
    @$el.html @template @params()

  render: ->
    @renderLayout()
    return @
