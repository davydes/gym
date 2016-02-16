class App.Views.Pictures.New extends App.View
  template: HandlebarsTemplates['pictures/new']
  id: 'pictures'

  events:
    'click button.save' : 'create'
    'change input[name=\'image\']': 'preview'

  initialize: ->
    @model = new App.Models.Picture()
    @model.collection = @collection
    @progress = new App.Views.Shared.Progress()
    @preview  = new App.Views.Shared.ImagePreview()

  renderLayout: ->
    @$el.html @template

  renderProgress: ->
    @$('#progress').empty().append(@progress.el)
    @progress.hide()
    @progress.render()

  renderPreview: ->
    @$('#preview').empty().append(@preview.el)
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

    @model.saveFormData formData,
      prepare: => @_uploadPrepare()
      progress: (prc) => @progress.progress(prc)
      finish: => @progress.infinite('')
      success: => @_uploadSuccess()
      error: (model, response) => @_uploadUnsuccess(model, response)

  preview: (e) ->
    @preview.setFile(e.currentTarget.files[0])

  _uploadPrepare: ->
    @progress.show()
    @progress.progress(0)

  _uploadSuccess: ->
    @progress.hide()
    @collection.add @model
    messages.success I18n.t 'pictures.messages.save_successful'
    app.navigate '', { trigger: true }

  _uploadUnsuccess: (model, response) ->
    @progress.hide()
    ev = new App.Views.ErrorView { el: @el, errors: new App.ErrorList(response) }
    ev.render()
    messages.danger I18n.t 'pictures.messages.save_unsuccessful'
