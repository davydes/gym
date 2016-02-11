class App.Collections.Pictures extends App.Collection

  model: App.Models.Picture

  url: () ->
    @baseUrl

  initialize: (models, options) ->
    @baseUrl = options.url