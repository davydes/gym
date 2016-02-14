class App.Models.Picture extends App.Model

  shallowApi: true

  urlRoot: '/pictures'

  saveFormData: (formData, options) ->
    method = if @isNew() then 'POST' else 'PUT'
    model = @

    $.ajax
      url: _.result(model, "url")
      type: method
      data: formData
      processData: false
      contentType: false

      beforeSend: ->
        options.beforeSend && options.beforeSend()

      success: (resp) ->
        model.set(model.parse(resp))
        model.trigger('sync', model, resp, options)
        options.success && options.success( model, resp, options )

      error: (resp) ->
        options.error && options.error( model, resp, options )

      xhr: ->
        options.xhr && options.xhr()