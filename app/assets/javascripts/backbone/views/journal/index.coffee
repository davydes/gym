class App.Views.Journal.Index extends App.CompositeView
  template: HandlebarsTemplates['journal/index']

  initialize: (options) ->
    @listenTo @collection, "reset remove add", @render

  render: ->
    @$el.html @template
    @collection.each (item) =>
      view = new App.Views.Journal.Item({ model: item })
      @appendChildTo(view, @el)
    return @