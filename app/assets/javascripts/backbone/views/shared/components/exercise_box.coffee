class App.Views.Shared.Components.ExerciseBox extends App.View
  template: HandlebarsTemplates['shared/components/exercise_box']
  tagName: 'select'

  events:
    'change' : '_selected'

  initialize: (options) ->
    if !App.reference_exercises?
      App.reference_exercises = new App.Collections.Exercise({}, { url: '/exercises' })
      App.reference_exercises.fetch()
    @collection = App.reference_exercises
    @listenTo(@collection, 'sync', @render)
    @name = if options? && options.name? then options.name else 'exercise_id'

  params: ->
    options:
      @collection.map (item) ->
        id: item.get('id')
        name: item.get('name')

  renderLayout: ->
    @$el.attr('name', @name)
    @$el.html @template @params()
    @_select()

  render: ->
    @renderLayout()
    return @

  getValue: ->
    return if (@value? && @value > 0) then @value else null

  setValue: (value) ->
    @value = value
    @_select()

  _select: ->
    @$('option[value="'+@value+'"]').attr('selected', 'selected') if @value?

  _selected: ->
    @value = @$el.val()
    @trigger('selected', @getValue())