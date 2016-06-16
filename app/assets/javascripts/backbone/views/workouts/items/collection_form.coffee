class App.Views.Workouts.Items.CollectionForm extends App.CompositeView
  template: HandlebarsTemplates['workouts/items/collection_form']
  className: 'workout-items-form'

  render: ->
    @$el.html @template
    @

  getFormData: ->
    []