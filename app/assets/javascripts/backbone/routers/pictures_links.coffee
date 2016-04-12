class App.Routers.PicturesLinks extends App.Router

  initialize: (options) ->
    @obj_type = options.obj_type
    @obj_id = options.obj_id
    @el = options.el
    @pictures = new App.Collections.Pictures options.pictures,
      url: options.url

  routes:
    '' : 'index'

  index: ->
    view = new App.Views.Pictures.Manage.Index
      collection: @pictures
      obj_type: @obj_type
      obj_id: @obj_id

    @swapView(view)