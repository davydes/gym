class App.Views.Workouts.Items.CollectionForm extends App.CompositeView
  template: HandlebarsTemplates['workouts/items/collection_form']
  className: 'workout-items'

  events:
    'click a.add-item' : 'addItem'
    'update-sort': 'updateSort'

  initialize: ->
    @listenTo(@collection, 'add', @renderItem)
    @listenTo(@collection, 'reset remove', @render)

  renderLayout: ->
    @$el.html @template
    new Sortable @$('ul.items').get(0),
      onEnd: (event) ->
        console.log $(event.item)
        $(event.item).trigger('drop', event.newIndex)

  renderItem: (item) ->
    container = @$('ul.items')
    view = new App.Views.Workouts.Items.ItemForm({ model: item })
    @appendChildTo(view, container)

  renderCollection: ->
    @cleanChildren()
    @collection.each (item) =>
      @renderItem item

  render: ->
    @renderLayout()
    @renderCollection()
    return @

  updateSort: (event, model, position) ->
    @collection.remove(model)
    @collection.each (model, index) ->
      pos = index
      if (index >= position)
        pos += 1
        model.set('pos', pos)

    model.set('pos', position)
    @collection.add(model, {at: position})
    @render()

  addItem: ->
    @collection.add(new App.Models.WorkoutItem())

  fetchForm: ->
    @children.each (child) ->
      child.fetchForm()