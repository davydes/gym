class App.Views.References.Exercises.Index extends App.CompositeView
  template: HandlebarsTemplates['references/exercises/index']

  renderLayout: ->
    @$el.html @template

  renderExercises: ->

  render: ->
    @renderLayout()
    return @