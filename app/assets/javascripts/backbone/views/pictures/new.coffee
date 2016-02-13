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
        @collection.add @model
        messages.success I18n.t 'pictures.messages.save_successful'
        app.navigate '',
          trigger: true

      error: (model, response) =>
        ev = new App.Views.ErrorView
          el: @el
          errors: new App.ErrorList(response)
        ev.render()
        messages.danger I18n.t 'pictures.messages.save_unsuccessful'

  fileInputChange: (e) ->
    file = e.currentTarget.files[0]

    if (file)
      reader = new FileReader()
      reader.onloadend = =>
        @_updatePreview reader.result
      reader.readAsDataURL file
    else
      @._updatePreview ''

  _updatePreview: (src) ->
    @$el.find('#preview-picture').attr 'src', src
