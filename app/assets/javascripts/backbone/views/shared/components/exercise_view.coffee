class App.Views.Shared.Components.ExerciseView extends App.View
  template: HandlebarsTemplates['shared/components/exercise_view']

  initialize: (options) ->
    unless App.reference_exercises?
      App.reference_exercises = new App.Collections.Exercise({}, { url: '/exercises' })
      App.reference_exercises.fetch()
    @collection = App.reference_exercises
    @listenTo(@collection, 'sync', @render)
    @name = if options? && options.name? then options.name else 'exercise'


  params: ->
    model = @collection.get(id: @modelId)
    return {

    }

  renderLayout: ->
    @$el.attr('name', @name)
    @$el.html @template @params()
    @_select()

  render: ->
    @renderLayout()
    return @