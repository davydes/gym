class App.Collections.WorkoutItem extends App.Collection
  model: App.Models.WorkoutItem

  comparator: (model) ->
    model.get('pos')

  sync: -> false