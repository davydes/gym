class App.Views.Pictures.Dialog.Finder extends App.CompositeView
  template: HandlebarsTemplates['pictures/dialog/finder']
  className: 'modal fade picture-finder'

  events:
    'click button.close' : 'close'
    'click button.ok' : 'ok'
    'hidden.bs.modal' : 'leave'

  initialize: (options) ->
    @obj_type = options.obj_type
    @obj_id = options.obj_id

  renderLayout: ->
    @$el.html @template

  renderBrowser: ->
    pictures = new App.Collections.Pictures(null, url: '/pictures')
    pictures.fetch(data: {obj_type: @obj_type, obj_id: @obj_id})
    view = new App.Views.Pictures.Dialog.List(collection: pictures)
    container = @$('#pictures-browser')
    @renderChildInto(view, container)
    @listenTo view, 'pickPicture', @pickPicture

  renderUploader: ->
    view = new App.Views.Pictures.Dialog.Uploader
      collection: new App.Collections.Pictures({}, url: '/pictures')
    container = @$('#picture-uploader')
    @renderChildInto(view, container)
    @listenTo view, 'uploadedPicture', @pickPicture

  render: ->
    @renderLayout()
    @renderBrowser()
    @renderUploader()
    return @

  open: ->
    @$el.modal 'show'

  close: ->
    @$el.modal 'hide'

  pickPicture: (id) ->
    @trigger 'pickPicture', id
    @close()

_.extend App.View, App.Mixins
