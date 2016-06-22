class App.Views.Journals.Items.Index extends App.CompositeView
  template: HandlebarsTemplates['journals/items/index']
  className: 'index'

  initialize: (options) ->
    @listenTo @collection, "reset remove add", @render

  params: ->
    hasAny: =>
      @collection.size() > 0

  render: ->
    @$el.html @template @params()
    c = @$('.list-group')
    @collection.each (item) =>
      view = new App.Views.Journals.Items.Item({ model: item })
      @appendChildTo(view, c)
    return @
