class App.Views.Journals.Items.Form extends App.CompositeView
  template: HandlebarsTemplates['journals/items/form']
  className: 'journal-item-form'

  initialize: ->
    @workoutFormView = new App.Views.Workouts.Form(model: @model.workout)

  events:
    'click .save' : 'save'
    'click .cancel' : 'cancel'

  renderLayout: ->
    @$el.html @template
    @_dateTimePicker('input[name=executed_at]', @model.get('executed_at'))

  renderWorkoutForm: ->
    container = @$('.workout-form')
    @renderChildInstead(@workoutFormView, container)

  render: ->
    @renderLayout()
    @renderWorkoutForm()
    return @

  cancel: (e) ->
    app.navigate '', trigger: true

  save: (e) ->
    @model.set 'executed_at', @$('input[name=executed_at]').data("DateTimePicker").date().unix()
    @workoutFormView.fetchForm()
    @model.save {},
      success: ->
        app.navigate '', trigger: true
      error: (model, response) =>
        ev = new App.Views.ErrorView { el: @el, errors: new App.ErrorList(response) }
        ev.render()

  _dateTimePicker: (selector, date) ->
    @$(selector).datetimepicker
      defaultDate: moment.unix(date)
      icons:
        time: 'fa fa-clock-o'
        date: 'fa fa-calendar'
        up: 'fa fa-arrow-up'
        down: 'fa fa-arrow-down'
        previous: 'fa fa-chevron-left'
        next: 'fa fa-chevron-right'
        today: 'fa fa-screenshot'
        clear: 'fa fa-trash'
        close: 'fa fa-remove'