class App.Router extends Backbone.Router
  swapView: (view) ->
    if @currentView
      if @currentView.leave
        @currentView.leave()
      else if @currentView.remove
        @currentView.remove()
    @currentView = view
    $(@el).html @currentView.render().el
    view.onShow() if view.onShow

_.extend App.Router, App.Mixins
