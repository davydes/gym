class App.Views.Workouts.Items.ItemForm extends App.CompositeView
  template: HandlebarsTemplates['workouts/items/item_form']
  tagName: 'li'
  className: 'workouts-items-item_form'

  events:
    'click a.delete' : 'destroy'

  render: ->
    @$el.html @template

  destroy: ->
    @model.destroy
      success: =>
        @leave