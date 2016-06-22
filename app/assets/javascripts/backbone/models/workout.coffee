class App.Models.Workout extends App.Model
  defaults:
    name: 'Unnamed Workout'

  sync: -> false

  initialize: ->
    @on('change:items', @parseItems)
    @parseItems()

  parseItems: ->
    @items = new App.Collections.WorkoutItem(@get('items'))

  toJSON: ->
    json = _.clone(@attributes)
    json.items = @items.map (item) ->
      item.toJSON()
    return json