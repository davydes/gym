class App.Routers.Profile extends App.Router

  initialize: (options) ->
    @el = options.el
    @model = new App.Models.Profile(options.profile)

  routes:
    '' : 'main'

  main: ->
    view = new App.Views.Profiles.Current(model: @model)
    @swapView(view)
