class App.Models.WorkoutItem extends App.Model
  sync: -> false

  initialize: ->
    @on('change:sets', @parseSets)
    @parseSets()

  parseSets: ->
    @sets = new App.Collections.WorkoutItemSet(@get('sets'))

  toJSON: ->
    json = _.clone(@attributes)
    json.sets = @sets.map (set) ->
      set.toJSON()
    return json