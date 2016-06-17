class App.Views.Shared.Components.ExerciseBox extends App.View
  template: HandlebarsTemplates['shared/components/exercise_box']
  tagName: 'select'

  events:
    'change select' : '_selected'

  initialize: ->
    if !App.reference_exercises?
      App.reference_exercises = new App.Collections.Exercise({}, { url: '/exercises' })
      App.reference_exercises.fetch()
    @collection = App.reference_exercises
    @listenTo(@collection, 'sync', @render)

  params: ->
    options:
      @collection.map (item) ->
        id: item.get('id')
        name: item.get('name')

  renderLayout: ->
    @$el.html @template @params()

  render: ->
    @renderLayout()
    return @

  getValue: ->
    value = @$el.val()
    return if (value? && value > 0) then value else null

  setValue: (value) ->
    @$('option[value="'+value+'"]').attr('selected', 'selected')

  _selected: ->
    @trigger('selected', @getValue())