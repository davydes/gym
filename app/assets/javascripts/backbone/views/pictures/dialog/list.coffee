class App.Views.Pictures.Dialog.List extends App.CompositeView
  template: HandlebarsTemplates['pictures/dialog/list']

  initialize: ->
    @listenTo @collection, "change reset remove add", @render

  renderItem: (item) ->
    view = new App.Views.Pictures.Dialog.ListItem({ model: item })
    container = @$('#picture-list')
    @appendChildTo(view, container)
    @listenTo(view, 'clickPicture', @clickPicture)

  render: ->
    @$el.html @template
    @collection.each (picture) =>
      @renderItem picture
    return @

  clickPicture: (id) ->
    @trigger 'pickPicture', id