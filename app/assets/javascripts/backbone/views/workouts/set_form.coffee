class App.Views.Workouts.SetForm extends App.CompositeView
  template: HandlebarsTemplates['workouts/set_form']
  tagName: 'li'
  className: 'list-group-item'

  events:
    'click a.delete-set' : 'onDestroy'

  params: ->
    weight: @model.get('weight')
    repeats: @model.get('repeats')

  renderLayout: ->
    @$el.html @template @params()

  render: ->
    @renderLayout()
    return @

  onDestroy: ->
    @model.destroy()

  fetchForm: ->
    @model.set 'weight', @$('input[name=\'workout.items.set.weight\']').val()
    @model.set 'repeats', @$('input[name=\'workout.items.set.repeats\']').val()