class App.Collections.Journal.Items extends App.Collection
  model: App.Models.Journal.Item

  url: ->
    @baseUrl

  initialize: (models, options) ->
    @baseUrl = options.url
