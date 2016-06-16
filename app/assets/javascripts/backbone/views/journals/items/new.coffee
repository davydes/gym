class App.Views.Journals.Items.New extends App.CompositeView
  template: HandlebarsTemplates['journals/items/new']
  className: 'journal-item-new'

  initialize: ->
    @model = new App.Models.JournalItem()
    @model.collection = @collection
    @workoutView = new App.Views.Workouts.Form()

  events:
    'click .save' : 'save'
    'click .cancel' : 'cancel'

  renderLayout: ->
    @$el.html @template
    @_dateTimePicker('input[name=executed_at]', @model.get('executed_at'))

  renderWorkout: ->
    container = @$('.workout-area')
    @appendChildTo(@workoutView, container)

  render: ->
    @renderLayout()
    @renderWorkout()
    return @

  cancel: (e) ->
    app.navigate '', trigger: true

  save: (e) ->
    @model.set 'executed_at', @$('input[name=executed_at]').data("DateTimePicker").date().unix()
    @model.set 'workout', @workoutView.getFormData()
    console.log @model.get('workout')
    @model.save()

  _dateTimePicker: (selector, date) ->
    @$(selector).datetimepicker
      defaultDate: moment.unix(date)
      icons:
        time: "fa fa-clock-o"
        date: "fa fa-calendar"
        up: "fa fa-arrow-up"
        down: "fa fa-arrow-down"
        previous: 'fa fa-chevron-left'
        next: 'fa fa-chevron-right'
        today: 'fa fa-screenshot'
        clear: 'fa fa-trash'
        close: 'fa fa-remove'