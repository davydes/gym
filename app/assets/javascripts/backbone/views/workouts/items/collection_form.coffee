class App.Views.Workouts.Items.CollectionForm extends App.CompositeView
  template: HandlebarsTemplates['workouts/items/collection_form']
  className: 'workouts-items-collection_form'

  events:
    'click a.add-item' : 'addItem'

  initialize: ->
    @collection = new App.Collections.WorkoutItemCollection()
    @listenTo(@collection, 'add', @renderItem)
    @listenTo(@collection, 'reset remove', @render)

  renderLayout: ->
    @$el.html @template

  renderItem: (item) ->
    container = @$('.workout-item-form')
    view = new App.Views.Workouts.Items.ItemForm({ model: item })
    @appendChildTo(view, container)

  renderCollection: ->
    @collection.each (item) =>
      @renderItem item

  render: ->
    @renderLayout()
    @renderCollection()
    return @

  addItem: ->
    @collection.add(new App.Models.WorkoutItem())

  getFormData: ->
    _.each @children, (item) ->
      console.log item
    return []