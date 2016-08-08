class App.Views.References.Exercises.Item extends App.CompositeView
  template: HandlebarsTemplates['references/exercises/item']

  tagName: 'li'
  className: 'list-group-item'

  params: ->
    name: @model.get('name')
    url: @model.url()

  renderLayout: ->
    @$el.html @template @params()

  render: ->
    @renderLayout()
    return @