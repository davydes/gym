class App.Views.Journal.Items.Show extends App.CompositeView
  template: HandlebarsTemplates['journal/items/show']

  initialize: (options) ->
    @listenTo @model, "change", @render

  render: ->
    @$el.html @template
    return @