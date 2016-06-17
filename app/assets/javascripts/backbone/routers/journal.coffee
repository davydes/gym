class App.Routers.Journal extends App.Router

  initialize: (options) ->
    @el = options.el
    @items = new App.Collections.JournalItem options.items,
      url: options.url

  routes:
    '' : 'index'
    'add' : 'add'
    'show/:id' : 'show'
    '404' : 'notFound'

  index: ->
    view = new App.Views.Journals.Items.Index
      collection: @items
    @swapView(view)

  add: ->
    view = new App.Views.Journals.Items.New
      collection: @items
    @swapView(view)

  show: (id) ->
    item = App.Models.JournalItem.findOrCreate(id: id)
    item.collection = @items
    item.fetch
      success: (model, response) =>
        view = new App.Views.Journals.Items.Show
          model: model
        @swapView(view)
      error: =>
        app.navigate '404', {trigger:true, replace:true}

  notFound: ->
    @swapView(new  App.Views.Shared.NotFound())
