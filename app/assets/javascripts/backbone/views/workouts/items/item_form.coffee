class App.Views.Workouts.Items.ItemForm extends App.CompositeView
  template: HandlebarsTemplates['workouts/items/item_form']
  tagName: 'li'

  events:
    'click a.delete' : 'onDestroy'

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

  onDestroy: ->
    @model.destroy()

  fetchForm: ->
    @model.set('exercise_id', @exercise_box.getValue())