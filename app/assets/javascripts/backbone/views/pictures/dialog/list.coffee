class App.Views.Pictures.Dialog.List extends App.CompositeView
  template: HandlebarsTemplates['pictures/dialog/list']

  initialize: (options) ->
    @obj_type = options.obj_type
    @obj_id = options.obj_id
    @collection = new App.Collections.Pictures {},
      url: '/pictures',
    @listenTo @collection, 'add', @renderItem
    @load()

  renderItem: (item) ->
    view = new App.Views.Pictures.Dialog.ListItem({ model: item })
    container = @$('#picture-list')
    @appendChildTo(view, container)
    @listenTo(view, 'clickPicture', @clickPicture)

  render: ->
    @$el.html @template
    return @

  clickPicture: (id) ->
    @trigger 'pickPicture', id

  load: ->
    @collection.fetch
      data:
        obj_type: @obj_type
        obj_id: @obj_id