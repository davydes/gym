class App.Models.JournalItem extends App.Model
  defaults:
    executed_at: moment().unix()

  initialize: ->
    @on('change:workout_attributes', @parseWorkout)
    @parseWorkout()

  parseWorkout: ->
    @workout = new App.Models.Workout(@get('workout_attributes'))

  toJSON: ->
    json = _.clone(@attributes)
    json.workout_attributes = @workout.toJSON()
    return json