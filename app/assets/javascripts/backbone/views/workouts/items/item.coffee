class App.Views.Workouts.Items.Item extends App.CompositeView
  template: HandlebarsTemplates['workouts/items/item']
  tagName: 'li'

  params: ->
    pos: @model.get('pos')
    sets: @model.get('sets')

  renderLayout: ->
    @$el.html @template @params()

  renderExercise: ->
    view = new App.Views.Shared.Components.ExerciseView(exercise_id: @model.get('exercise_id'))
    @renderChildInstead(view, @$('.exercise'))

  render: ->
    @renderLayout()
    @renderExercise()
    return @