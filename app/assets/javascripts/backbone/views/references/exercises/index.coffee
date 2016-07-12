#todo: cancan abilities
#todo: grouping models
#todo: sorting models

class App.Views.References.Exercises.Index extends App.FilterableView
  template: HandlebarsTemplates['references/exercises/index']

  initialize: ->
    super
    @listenTo(@filteredCollection, 'add', 'renderItem')
    @listenTo(@filteredCollection, 'reset remove', 'render')

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
    @filteredCollection.each (item) =>
      @renderItem(item)

  render: ->
    @renderLayout()
    @renderFilter()
    @renderItems()
    return @

  filterFunction: (options) =>
    return (model) =>
      !options.name || model.get('name').indexOf(options.name) > -1