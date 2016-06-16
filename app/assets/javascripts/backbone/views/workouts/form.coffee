class App.Views.Workouts.Form extends App.CompositeView
  template: HandlebarsTemplates['workouts/form']
  className: 'workout-form'

  initialize: ->
    @model = new App.Models.Workout()
    @itemsView = new App.Views.Workouts.Items.CollectionForm()

  params: ->
    @model.toJSON()

  renderLayout: ->
    @$el.html @template @params()

  renderItems: ->
    container = @$('.workout-items')
    @appendChildTo(@itemsView, container)

  render: ->
    @renderLayout()
    @renderItems()
    return @

  getFormData: ->
    name: @$('input[name=\'workout[name]\']').val()
    items: @itemsView.getFormData()