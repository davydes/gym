class App.Views.Pictures.Index extends App.View

  tagName: 'tbody'
  id: 'picture-list'

  initialize: () ->
    _.bindAll(this, "render");
    @listenTo @collection, "change reset remove add", @render

  render: () ->
    console.log 'render '+@collection.length
    @$el.empty()
    @collection.each (picture) =>
      view = new App.Views.Pictures.Item({ model: picture })
      @$el.append view.render().el
    $('#'+@id).replaceWith(@el)
    return @