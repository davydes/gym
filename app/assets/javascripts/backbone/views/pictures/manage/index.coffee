class App.Views.Pictures.Manage.Index extends App.CompositeView
  template: HandlebarsTemplates['pictures/manage/index']
  id: 'pictures'

  events:
    'click a.add' : 'selectPicture'

  initialize: (options) ->
    @listenTo @collection, "change reset remove add", @render
    @obj_type = options.obj_type
    @obj_id = options.obj_id


  render: () ->
    @$el.html @template
    container = @$('#picture-list')
    @collection.each (picture) =>
      view = new App.Views.Pictures.Manage.Item({ model: picture })
      @appendChildTo(view, container)
    return @

  selectPicture: ->
    view = new App.Views.Pictures.Dialog.Finder
      obj_type: @obj_type
      obj_id: @obj_id
    @listenTo view, 'pickPicture', @addPicture
    $('body').append(view.render().el)
    view.open()

  addPicture: (id) ->
    model = @collection.create {l_id: id}, wait: true
