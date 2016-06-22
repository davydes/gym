class App.Views.Journals.Items.Item extends App.CompositeView
  template: HandlebarsTemplates['journals/items/item']
  className: 'list-group-item'
  tagName: 'a'

  events:
    'click' : 'onClick'

  initialize: (options) ->
    @id = @model.get('id')
    @listenTo @model, "change", @render

  params: ->
    id: @model.get('id')
    executed_at: moment.unix(@model.get('executed_at')).format('YYYY.MM.DD HH:MM')
    count: @model.workout.items.length
    workout_name: @model.workout.get('name')

  render: ->
    @$el.html @template @params()
    return @

  onClick: ->
    app.navigate "show/#{@id}", trigger: true