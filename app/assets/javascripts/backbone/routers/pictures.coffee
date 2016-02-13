class App.Routers.Pictures extends App.Router

  initialize: (options) ->
    @el = options.el
    @pictures = new App.Collections.Pictures options.pictures,
      url: options.url

  routes:
    '' : 'index'
    'new' : 'new'

  index: ->
    view = new App.Views.Pictures.Index(collection: @pictures)
    @swapView(view)

  new: ->
    view = new App.Views.Pictures.New(collection: @pictures)
    @swapView(view)