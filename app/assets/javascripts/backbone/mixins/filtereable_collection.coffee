App.Mixins.FilterableCollection =
  filtered: (criteriaFunction) ->
    filteredCollection = @clone()

    applyFilter = =>
      filteredCollection.reset(@select(criteriaFunction))

    @listenTo(@, "add change remove", applyFilter)
    applyFilter()

    return filteredCollection