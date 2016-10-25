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
    @$('ul.items').sortable
      distance: 25
      stop: (event, ui) ->
        ui.item.trigger('drop', ui.item.index())

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
    @restoreScrollPosition()
    return @

  updateSort: (event, model, position) ->
    @saveScrollPosition()
    @fetchForm()
    @collection.remove(model)
    @collection.add(model, {at: position})
    @render()

  numerate: ->
    @collection.each (model, index) ->
      model.set('pos', index+1)

  restoreScrollPosition: ->
    $(window).scrollTop(@current_pos) if @current_pos

  saveScrollPosition: ->
    @current_pos = $(window).scrollTop()

  addItem: ->
    @collection.add(new App.Models.WorkoutItem())

  fetchForm: ->
    @children.each (child) ->
      child.fetchForm()
    @numerate()
