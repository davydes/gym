App.Mixins.SortableCollection =
  sortedBy: (comparator) ->
    sortedCollection = @clone()
    sortedCollection.comparator = comparator

    applySort = =>
      sortedCollection.reset(@models, silent: true)
      sortedCollection.sort(silent: true)
      sortedCollection.trigger('change')

    sortedCollection.listenTo(@, "add remove change", applySort)

    applySort()

    return sortedCollection