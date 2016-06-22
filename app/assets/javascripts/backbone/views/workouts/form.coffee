class App.Views.Workouts.Form extends App.CompositeView
  template: HandlebarsTemplates['workouts/form']
  className: 'workout-form'

  initialize: ->
    @itemsView = new App.Views.Workouts.Items.CollectionForm(collection: @model.items)

  params: ->
    @model.toJSON()

  renderLayout: ->
    @$el.html @template @params()

  renderCollectionForm: ->
    container = @$('.workout-items')
    @renderChildInstead(@itemsView, container)

  render: ->
    @renderLayout()
    @renderCollectionForm()
    return @

  fetchForm: ->
    @model.set('name', @$('input[name=\'workout[name]\']').val())
    @itemsView.fetchForm()