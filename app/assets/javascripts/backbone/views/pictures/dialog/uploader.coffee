class App.Views.Pictures.Dialog.Uploader extends App.CompositeView
  template: HandlebarsTemplates['pictures/dialog/uploader']
  id: 'pictures'

  events:
    'click button.save' : 'create'
    'change input[name=\'image\']': 'preview'

  initialize: (options) ->
    @model = new App.Models.Picture()
    @model.collection = @collection
    @progress = new App.Views.Shared.Progress()
    @preview  = new App.Views.Shared.ImagePreview()

  renderLayout: ->
    @$el.html @template
    @$(':file').filestyle
      buttonName: "btn-primary"
      buttonBefore: true
      buttonText: I18n.t 'pictures.uploader.pick_file'
      iconName: 'fa fa-folder-open'
      placeholder: I18n.t 'pictures.uploader.file_placeholder'

  renderProgress: ->
    container = @$('#progress')
    @renderChildInto(@progress, container)
    @progress.hide()
    @progress.render()

  renderPreview: ->
    container = @$('#preview')
    @renderChildInto(@preview, container)
    @preview.hide()
    @preview.render()

  render: ->
    @renderLayout()
    @renderProgress()
    @renderPreview()
    return @

  remove: ->
    @progress.remove()
    @preview.remove()
    super

  create: (e) ->
    e.preventDefault()

    formData = new FormData()
    formData.append("picture[name]", @$('input[name=\'name\']').val())
    formData.append("picture[image]", @$('input[name=\'image\']')[0].files[0])

    @listenTo @model, 'upload:prepare', @_uploadPrepare
    @listenTo @model, 'upload:progress', @_setProgress
    @listenTo @model, 'upload:success', @_uploadSuccess
    @listenTo @model, 'upload:finish', @_setFinish
    @listenTo @model, 'upload:error', @_uploadUnsuccess

    @model.saveFormData formData

  preview: (e) ->
    @preview.setFile(e.currentTarget.files[0])

  _setProgress: (prc) ->
    @progress.progress(prc)

  _setFinish: ->
    @progress.infinite('')

  _uploadPrepare: ->
    @progress.show()
    @progress.progress(0)

  _uploadSuccess: ->
    @progress.hide()
    @trigger 'uploadedPicture', @model.id

  _uploadUnsuccess: (model, response) ->
    @progress.hide()
    ev = new App.Views.ErrorView { el: @el, errors: new App.ErrorList(response) }
    ev.render()
