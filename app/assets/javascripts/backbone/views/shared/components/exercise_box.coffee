class App.Views.Shared.Components.ExerciseBox extends App.View
  template: HandlebarsTemplates['shared/components/exercise_box']

  events:
    'change select' : 'onSelect'

  initialize: ->
    @collection = new App.Collections.Exercise({}, { url: '/exercises' })
    @listenTo(@collection, 'add', @renderItem)
    @collection.fetch()

  renderItem: (item) ->
    @$('select').append("<option>#{item.get('name')}</option>")

  render: ->
    @$el.html @template
    return @

  onSelect: ->
    @trigger('selected', @getValue())

  getValue: ->
    @$('select').val()