class App.Views.Workouts.Form extends App.CompositeView
  template: HandlebarsTemplates['workouts/form']
  className: 'workouts-form'

  initialize: ->
    items = @model.get('items')
    if !items?
      items = new App.Collections.JournalItemCollection()
      @model.set('items', items)
    @itemsView = new App.Views.Workouts.Items.CollectionForm(collection: items)

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

  fetchForm: ->
    @model.set('name', @$('input[name=\'workout[name]\']').val())
    @itemsView.fetchForm()