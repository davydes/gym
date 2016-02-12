class App.Routers.Pictures extends App.Router

  initialize: (options) ->
    @pictures = new App.Collections.Pictures options.pictures,
      url: options.url

  routes:
    '' : 'index'
    'new' : 'new'

  index: ->
    view = new App.Views.Pictures.Index(collection: @pictures)
    $('#pictures').html(view.el)
    view.render()

  new: ->
    view = new App.Views.Pictures.New(collection: @pictures)
    $('#pictures').html(view.el)
    view.render()