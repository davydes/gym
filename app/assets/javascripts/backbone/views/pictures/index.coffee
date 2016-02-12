class App.Views.Pictures.Index extends App.View
  template: HandlebarsTemplates['pictures/index']
  id: 'pictures'

  initialize: () ->
    _.bindAll(@, "render")
    @listenTo @collection, "change reset remove add", @render

  render: () ->
    @$el.html @template
    @collection.each (picture) =>
      view = new App.Views.Pictures.Item({ model: picture })
      @$('#picture-list').append view.render().el
    return @
