class App.Router extends Backbone.Router
  swapView: (view) ->
    @currentView && @currentView.remove()
    @currentView = view
    $(@el).html @currentView.render().el

_.extend App.Router, App.Mixins