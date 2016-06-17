class App.Views.Workouts.Items.ItemForm extends App.CompositeView
  template: HandlebarsTemplates['workouts/items/item_form']
  tagName: 'li'
  id: -> @model.cid

  events:
    'click a.delete' : 'onDestroy'
    'drop' : 'drop'

  initialize: ->
    @exercise_box = new App.Views.Shared.Components.ExerciseBox()

  renderLayout: ->
    @$el.html @template

  renderExerciseBox: ->
    @appendChildTo(@exercise_box, @$('.exercises_box'))
    value = @model.get('exercise_id')
    @exercise_box.setValue(value) if value

  render: ->
    @renderLayout()
    @renderExerciseBox()
    return @

  drop: (event, index) ->
    console.log index
    @$el.trigger('update-sort', [@model, index])

  onDestroy: ->
    @model.destroy()

  fetchForm: ->
    @model.set('exercise_id', @exercise_box.getValue())