#todo: cancan abilities
#todo: grouping models
#todo: sorting models

class App.Views.References.Exercises.Index extends App.CompositeView
  template: HandlebarsTemplates['references/exercises/index']

  renderLayout: ->
    @$el.html @template

  renderFilter: ->
    container = @$('.filter')
    @filterView = new App.Views.References.Exercises.Filter()
    @renderChildInstead(@filterView, container)
    @listenTo(@filterView, 'filter', @applyFilter)

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
    @applyFilter(@filterView.getFilterData())
    return @

  applyFilter: (options) ->
    if @sortedCollection?
      @stopListening(@sortedCollection)
      @sortedCollection.stopListening()
    if @filteredCollection?
      @filteredCollection.stopListening()
    @filteredCollection = @collection.filtered(@filterFunction(options))
    @sortedCollection = @filteredCollection.byName()
    @listenTo(@sortedCollection, 'change', @renderItems)
    @renderItems()

  filterFunction: (options) =>
    options = {} unless options?
    return (model) =>
      result = true
      if options.equipment?
        result = result && (model.equipments.map((eq)-> eq.get('id')).includes(options.equipment))
      if options.body_part?
        result = result && (model.body_parts.map((eq)-> eq.get('id')).includes(options.body_part))
      result