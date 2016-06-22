class App.Routers.Journal extends App.Router

  initialize: (options) ->
    @el = options.el
    @items = new App.Collections.JournalItem null, {url: options.url}

  routes:
    ''         : 'index'
    'new'      : 'new'
    'show/:id' : 'show'
    'edit/:id' : 'edit'
    '404'      : 'notFound'

  index: ->
    view = new App.Views.Journals.Items.Index
      collection: @items
    @items.fetch()
    @swapView(view)

  new: ->
    item = new App.Models.JournalItem()
    item.collection = @items
    view = new App.Views.Journals.Items.Form(model: item)
    @swapView(view)

  show: (id) ->
    item = new App.Models.JournalItem({id: id})
    item.collection = @items
    item.fetch
      success: (model, response) =>
        view = new App.Views.Journals.Items.Show
          model: model
        @swapView(view)
      error: =>
        app.navigate '404', {trigger:true, replace:true}

  edit: (id) ->
    item = new App.Models.JournalItem(id: id)
    item.collection = @items
    item.fetch
      success: (model, response) =>
        view = new App.Views.Journals.Items.Form
          model: model
        @swapView(view)
      error: =>
        app.navigate '404', {trigger:true, replace:true}

  notFound: ->
    @swapView(new  App.Views.Shared.NotFound())
