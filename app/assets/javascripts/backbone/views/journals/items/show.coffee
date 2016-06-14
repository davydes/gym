class App.Views.Journals.Items.Show extends App.CompositeView
  template: HandlebarsTemplates['journals/items/show']

  initialize: (options) ->
    @listenTo @model, "change", @render

  render: ->
    @$el.html @template
    return @