class App.Views.Shared.ImagePreview extends App.View
  template: HandlebarsTemplates['shared/image_preview']

  hide: ->
    @$el.addClass 'hide'

  show: ->
    @$el.removeClass 'hide'

  setFile: (file) ->
    if ( file )
      reader = new FileReader()
      reader.onloadend = => ( @setPreview reader.result, file.name )
      reader.readAsDataURL file
    else
      @clearPreview()

  setPreview: (src, caption) ->
    @$('img').attr 'src', src
    @$('.caption').text caption
    @show()

  clearPreview: ->
    @$('img').attr 'src', ''
    @$('.caption').text ''
    @hide()

  render: ->
    @$el.html @template
    return @