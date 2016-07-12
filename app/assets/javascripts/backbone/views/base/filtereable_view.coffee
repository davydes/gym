class App.FilterableView extends App.CompositeView
  initialize: (options) ->
    @filteredCollection = @collection.filtered(@filterFunction)

  applyFilter: (options) ->
    @filteredCollection.stopListening()
    @filteredCollection = @collection.filtered(@filterFunction(options))
    @render()