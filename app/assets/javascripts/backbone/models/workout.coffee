class App.Models.Workout extends App.RelationalModel
  defaults:
    name: 'Unnamed Workout'

  relations: [{
    type: 'HasMany'
    key: 'items'
    relatedModel: 'App.Models.WorkoutItem'
    relatedCollection: 'App.Collections.WorkoutItemCollection'
  }]

  sync: -> false
