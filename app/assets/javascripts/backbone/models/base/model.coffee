class App.Model extends Backbone.Model

  shallowUrl: ->
    if (@isNew())
      return _.result(@collection, 'url')
    base =
      _.result(@, 'urlRoot') ||
        _.result(@collection, 'url') ||
        urlError()
    id = @id || @attributes[@idAttribute]
    base.replace(/([^\/])$/, '$1/') + encodeURIComponent(id)

  url: ->
    if (@shallowApi)
      return @shallowUrl()
    super

_.extend App.Model, App.Mixins

