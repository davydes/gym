class App.Models.Picture extends App.Model
  defaults:
    'image_processing': false

  saveFormData: (formData, options) ->
    method = if @isNew() then 'POST' else 'PUT'

    $.ajax
      url: _.result(@, "url")
      type: method
      data: formData
      processData: false
      contentType: false
      context: @

      beforeSend: ->
        @trigger('upload:prepare')

      success: (resp) ->
        @set(@parse(resp))
        @trigger('sync upload:success', @, resp, options)

      error: (resp) ->
        @trigger('upload:error', @, resp, options)

      xhr: =>
        xhr = new window.XMLHttpRequest()
        xhr.upload.addEventListener(
          'progress'
          (e) => @trigger('upload:progress', Math.round(100 * e.loaded / e.total)) if (e.lengthComputable)
          false
        )
        xhr.upload.addEventListener(
          'load'
          (e) => @trigger('upload:finish')
          false
        )
        return xhr