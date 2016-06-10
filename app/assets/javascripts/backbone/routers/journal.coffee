class App.Routers.Journal extends App.Router

  initialize: (options) ->
    @el = options.el
    @items = new App.Collections.Journal.Items options.items,
      url: options.url

  routes:
    '' : 'index'

  index: ->
    view = new App.Views.Journal.Index
      collection: @items
      el: @el
    @swapView(view)