class App.Models.JournalItem extends App.Model
  defaults:
    executed_at: moment().unix()

  initialize: ->
    @on('change:workout', @parseWorkout)
    @parseWorkout()

  parseWorkout: ->
    @workout = new App.Models.Workout(@get('workout'))

  toJSON: ->
    json = _.clone(@attributes)
    json.workout = @workout.toJSON()
    return json