class App.Views.Workouts.Items.ItemForm extends App.CompositeView
  template: HandlebarsTemplates['workouts/items/item_form']
  tagName: 'li'
  className: 'list-group-item'
  id: -> @model.cid

  events:
    'click a.delete' : 'onDestroy'
    'drop' : 'drop'

  initialize: ->
    @exercise_box = new App.Views.Shared.Components.ExerciseBox({className: 'form-control', name: 'workout.items.exercise'})
    @setsView = new App.Views.Workouts.SetCollectionForm({ collection: @model.sets })

  params: ->
    cid: @model.cid

  renderLayout: ->
    @$el.html @template @params()

  renderExerciseBox: ->
    @appendChildTo(@exercise_box, @$('.exercises_box'))
    value = @model.get('exercise_id')
    @exercise_box.setValue(value) if value?

  renderSets: ->
    @appendChildTo(@setsView, @$('.well.sets'))

  render: ->
    @renderLayout()
    @renderExerciseBox()
    @renderSets()
    return @

  drop: (event, index) ->
    @$el.trigger('update-sort', [@model, index])

  onDestroy: ->
    @model.destroy()

  fetchForm: ->
    @model.set('exercise_id', @exercise_box.getValue())
    @setsView.fetchForm()