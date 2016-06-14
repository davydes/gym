class App.Routers.Journal extends App.Router

  initialize: (options) ->
    @el = options.el
    @items = new App.Collections.Journal.Items options.items,
      url: options.url

  routes:
    '' : 'index'
    'add' : 'add'
    'show/:id' : 'show'

  index: ->
    view = new App.Views.Journal.Items.Index
      collection: @items
    @swapView(view)

  add: ->
    view = new App.Views.Journal.Items.New
      collection: @items
    @swapView(view)

  show: (id) ->
    console.log 'Journal.Router#show '+id
    view = new App.Views.Journal.Items.Show
      collection: @items
    @swapView(view)
