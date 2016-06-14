class App.Views.Journal.Items.New extends App.CompositeView
  template: HandlebarsTemplates['journal/items/new']
  className: 'journal-item-new'

  initialize: ->
    @model = new App.Models.Journal.Item(collection: @collection)

  events:
    'click .save' : 'save'
    'click .cancel' : 'cancel'

  render: ->
    @$el.html @template
    @$('input[name=executed_at]').datetimepicker
      defaultDate: moment.unix(@model.get('executed_at'))
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
    return @

  cancel: (e) ->
    app.navigate '', trigger: true

  save: (e) ->
    console.log @$('#datetimepicker').data("DateTimePicker").date().unix()
