class App.Views.Workouts.Item extends App.CompositeView
  template: HandlebarsTemplates['workouts/item']
  tagName: 'li'

  initialize: ->
    @exerciseView = new App.Views.Shared.Components.ExerciseBox()

  params: ->
    pos: @model.get('pos')
    sets: @model.get('sets')

  renderLayout: ->
    @$el.html @template @params()

  renderExercise: ->
    @renderChildInstead(@exerciseView, @$('.exercise'))
    @exerciseView.setValue(@model.get('exercise_id'))

  render: ->
    @renderLayout()
    @renderExercise()
    return @