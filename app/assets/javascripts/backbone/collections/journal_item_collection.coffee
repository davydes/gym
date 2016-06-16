class App.Collections.JournalItemCollection extends App.Collection
  model: App.Models.JournalItem

  url: ->
    @baseUrl

  initialize: (models, options) ->
    @baseUrl = options.url
