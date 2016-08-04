App.Mixins.FilterableCollection =
  filtered: (criteriaFunction) ->
    filteredCollection = @clone()

    applyFilter = =>
      filteredCollection.reset(@select(criteriaFunction), silent: true)
      filteredCollection.trigger('change')

    filteredCollection.listenTo(@, "add remove change", applyFilter)
    applyFilter()

    return filteredCollection