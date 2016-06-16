class App.Collections.Exercise extends App.Collection
  model: App.Models.Exercise

  url: ->
    @baseUrl

  initialize: (models, options) ->
    @baseUrl = options.url