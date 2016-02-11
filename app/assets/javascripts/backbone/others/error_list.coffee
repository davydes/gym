class App.ErrorList

  constructor: (response) ->
    @attributesWithErrors = JSON.parse(response.responseText)['errors'] if (response && response.responseText)

  each: (iterator) ->
    _.each @attributesWithErrors, iterator

  size: ->
    _.size @attributesWithErrors