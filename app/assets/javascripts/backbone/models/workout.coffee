class App.Models.Workout extends App.Model
  defaults:
    name: 'Unnamed Workout'

  sync: -> false

  initialize: ->
    @on('change:items_attributes', @parseItems)
    @parseItems()

  parseItems: ->
    @items = new App.Collections.WorkoutItem(@get('items_attributes'))

  toJSON: ->
    json = _.clone(@attributes)
    json.items_attributes = @items.map (item) ->
      item.toJSON()
    return json