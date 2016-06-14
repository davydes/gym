class App.Views.Journal.Items.Item extends App.CompositeView
  template: HandlebarsTemplates['journal/items/item']
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
    count: @model.get('workout').items.length
    workout_name: @model.get('workout').name

  render: ->
    @$el.html @template @params()
    return @

  onClick: ->
    app.navigate "show/#{@id}", trigger: true