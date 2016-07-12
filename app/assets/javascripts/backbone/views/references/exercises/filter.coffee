class App.Views.References.Exercises.Filter extends App.CompositeView
  template: HandlebarsTemplates['references/exercises/filter']
  className: '.filter'

  events:
    'click .filter': 'filter'

  renderLayout: ->
    @$el.html @template

  render: ->
    @renderLayout()
    return @

  filter: ->
    @trigger('filter', {name: @$('input').val()})