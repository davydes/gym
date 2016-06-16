class App.Views.Workouts.Items.ItemForm extends App.CompositeView
  template: HandlebarsTemplates['workouts/items/item_form']
  tagName: 'li'

  events:
    'click a.delete' : 'destroy'

  renderLayout: ->
    @$el.html @template

  renderExerciseBox: ->
    @appendChild(new App.Views.Shared.Components.ExerciseBox())

  render: ->
    @renderLayout()
    @renderExerciseBox()
    return @

  destroy: ->
    @model.destroy
      success: =>
        @leave