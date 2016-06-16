class App.Views.Workouts.Form extends App.CompositeView
  template: HandlebarsTemplates['workouts/form']
  className: 'workouts-form'

  initialize: ->
    @model = new App.Models.Workout()
    @itemsView = new App.Views.Workouts.Items.CollectionForm()

  params: ->
    @model.toJSON()

  renderLayout: ->
    @$el.html @template @params()

  renderCollectionForm: ->
    container = @$('.workout-items-collection-form')
    @appendChildTo(@itemsView, container)

  render: ->
    @renderLayout()
    @renderCollectionForm()
    return @

  getFormData: ->
    name: @$('input[name=\'workout[name]\']').val()
    items: @itemsView.getFormData()