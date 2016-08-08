class App.Collections.BodyPart extends App.Collection
  model: App.Models.BodyPart

  url: ->
    @baseUrl

  initialize: (models, options) ->
    @baseUrl = options.url if options? && options.url?