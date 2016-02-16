class App.Models.Picture extends App.Model

  shallowApi: true

  urlRoot: '/pictures'

  saveFormData: (formData, options) ->
    method = if @isNew() then 'POST' else 'PUT'
    model = @

    xhr = (progress, finish) ->
      xhr = new window.XMLHttpRequest()
      xhr.upload.addEventListener 'progress', ((e) ->
        if (e.lengthComputable)
          progress && progress(Math.round(100 * e.loaded / e.total))
      ), false
      xhr.upload.addEventListener 'load', ((e) ->
        finish && finish()
      ), false
      return xhr

    $.ajax
      url: _.result(model, "url")
      type: method
      data: formData
      processData: false
      contentType: false

      beforeSend: ->
        options.prepare && options.prepare()

      success: (resp) ->
        model.set(model.parse(resp))
        model.trigger('sync', model, resp, options)
        options.success && options.success( model, resp, options )

      error: (resp) ->
        options.error && options.error( model, resp, options )

      xhr: ->
        xhr(options.progress, options.finish)