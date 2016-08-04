#todo: cancan abilities
#todo: grouping models
#todo: sorting models

class App.Views.References.Exercises.Index extends App.CompositeView
  template: HandlebarsTemplates['references/exercises/index']

  initialize: ->
    @filteredCollection = @collection.filtered(@filterFunction)
    @sortedCollection = @filteredCollection.byName()
    @listenTo(@sortedCollection, 'change', @render)

  renderLayout: ->
    @$el.html @template

  renderFilter: ->
    container = @$('.filter')
    view = new App.Views.References.Exercises.Filter()
    @renderChildInstead(view, container)
    @listenTo(view, 'filter', @applyFilter)

  renderItem: (item) ->
    container = @$('ul')
    view = new App.Views.References.Exercises.Item(model: item)
    @appendChildTo(view, container)

  renderItems: ->
    @$('ul').html('')
    @sortedCollection.each (item) =>
      @renderItem(item)

  render: ->
    @renderLayout()
    @renderFilter()
    @renderItems()
    return @

  applyFilter: (options) ->
    @sortedCollection.stopListening()
    @filteredCollection.stopListening()
    @filteredCollection = @collection.filtered(@filterFunction(options))
    @sortedCollection = @filteredCollection.byName()
    @renderItems()

  filterFunction: (options) =>
    return (model) =>
      !options.name || model.get('name').indexOf(options.name) > -1