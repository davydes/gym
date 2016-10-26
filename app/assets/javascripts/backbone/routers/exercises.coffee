class App.Routers.Exercises extends App.Router

  initialize: (options) ->
    @el = options.el
    @collection = new App.Collections.Exercise(options.exercises, {url: options.url})

  routes:
    '' : 'index'

  index: ->
    view = new App.Views.References.Exercises.Index(collection: @collection)
    @swapView(view)