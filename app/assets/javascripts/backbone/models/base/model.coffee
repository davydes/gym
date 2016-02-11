class App.Model extends Backbone.Model
_.extend App.Model, App.Mixins

App.Model.prototype.shallowUrl = ->
  if (@isNew())
    return _.result(@collection, 'url')
  base =
    _.result(@, 'urlRoot') ||
    _.result(@collection, 'url') ||
    urlError()
  id = @id || @attributes[@idAttribute];
  base.replace(/([^\/])$/, '$1/') + encodeURIComponent(id)

App.Model.prototype.url = ->
  if (@shallowApi)
    return @shallowUrl()
  super