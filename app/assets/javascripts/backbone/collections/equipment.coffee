class App.Collections.Equipment extends App.Collection
  model: App.Models.Equipment

  url: ->
    @baseUrl

  initialize: (models, options) ->
    @baseUrl = options.url if options? && options.url?