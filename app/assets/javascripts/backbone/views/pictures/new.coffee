class App.Views.Pictures.New extends App.View
  template: HandlebarsTemplates['pictures/new']
  id: 'pictures'

  events:
    'click button.save' : 'create'
    'change input[name=\'image\']': 'fileInputChange'

  initialize: ->
    @model = new App.Models.Picture()
    @model.collection = @collection

  render: ->
    @$el.html @template
    return @

  create: (e) ->
    e.preventDefault()

    formData = new FormData()
    formData.append("picture[name]", @$('input[name=\'name\']').val())
    formData.append("picture[image]", @$('input[name=\'image\']')[0].files[0])

    @model.saveFormData formData,
      success: =>
        @hideProgress()
        @collection.add @model
        messages.success I18n.t 'pictures.messages.save_successful'
        app.navigate '',
          trigger: true

      error: (model, response) =>
        @hideProgress()
        ev = new App.Views.ErrorView
          el: @el
          errors: new App.ErrorList(response)
        ev.render()
        messages.danger I18n.t 'pictures.messages.save_unsuccessful'

      xhr: =>
        xhr = new window.XMLHttpRequest()
        xhr.upload.addEventListener 'progress', ((e) =>
          if (e.lengthComputable)
            @setProgress(Math.round(100 * e.loaded / e.total))
        ), false
        xhr.upload.addEventListener 'load', ((e) =>
          @setProgressInternal()
        ), false
        return xhr

      beforeSend: =>
        @showProgress()
        @setProgress(0)

  fileInputChange: (e) ->
    file = e.currentTarget.files[0]

    if (file)
      reader = new FileReader()
      reader.onloadend = =>
        @updatePreview reader.result
      reader.readAsDataURL file
    else
      @.updatePreview ''

  updatePreview: (src) ->
    if src? && src.length > 0
      $('#preview', @$el).removeClass 'hide'
      $('#preview-picture', @$el).attr 'src', src
    else
      $('#preview', @$el).addClass 'hide'

  showProgress: ->
    $('#progress', @$el).removeClass 'hide'

  hideProgress: ->
    $('#progress', @$el).addClass 'hide'

  setProgress: (prc) ->
    $('#progress .progress-bar', @$el)
      .removeClass 'progress-bar-striped active'
      .css 'width', prc+'%'
      .attr 'aria-valuenow', prc
      .html prc+'%'

  setProgressInternal: ->
    @setProgress 100
    $('#progress .progress-bar', @$el)
      .addClass 'progress-bar-striped active'
      .html '...'
