class App.Collections.JournalItem extends App.Collection
  model: App.Models.JournalItem

  url: ->
    @baseUrl

  initialize: (models, options) ->
    @baseUrl = options.url
