class App.Views.Workouts.SetCollectionForm extends App.CompositeView
  template: HandlebarsTemplates['workouts/set_collection_form']
  className: 'workout-item-sets'

  events:
    'click a.add-set' : 'addSet'

  initialize: ->
    @listenTo(@collection, 'add', @renderSet)
    @listenTo(@collection, 'reset remove', @render)

  renderLayout: ->
    @$el.html @template

  renderSet: (item) ->
    view = new App.Views.Workouts.SetForm({ model: item })
    @appendChildTo(view, @$('ul.sets'))

  renderCollection: ->
    @cleanChildren()
    @collection.each (item) =>
      @renderSet item

  render: ->
    @renderLayout()
    @renderCollection()
    return @

  addSet: ->
    @collection.add(new App.Models.WorkoutItemSet())

  fetchForm: ->
    @children.each (child) ->
      child.fetchForm()