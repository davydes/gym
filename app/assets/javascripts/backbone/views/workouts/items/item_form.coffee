class App.Views.Workouts.Items.ItemForm extends App.CompositeView
  template: HandlebarsTemplates['workouts/items/item_form']
  tagName: 'li'

  events:
    'click a.delete' : 'destroy'

  initialize: ->
    @exercise_box = new App.Views.Shared.Components.ExerciseBox()

  renderLayout: ->
    @$el.html @template

  renderExerciseBox: ->
    @appendChild @exercise_box

  render: ->
    @renderLayout()
    @renderExerciseBox()
    return @

  getFormData: ->
    exercise_id: @exercise_box.getValue()

  destroy: ->
    @model.destroy
      success: =>
        @leave