class App.CompositeView extends Backbone.View

  constructor: ->
    @children = _([])
    super

  leave: ->
    @stopListening()
    @remove()
    @_leaveChildren()
    @_removeFromParent()

  renderChild: (view) ->
    view.render()
    @children.push(view)
    view.parent = @

  renderChildInto: (view, container) ->
    @renderChild(view)
    $(container).empty().append(view.el)

  appendChild: (view) ->
    @renderChild(view)
    $(@el).append(view.el)

  appendChildTo: (view, container) ->
    @renderChild(view)
    $(container).append(view.el)

  prependChild: (view) ->
    @renderChild(view)
    $(@el).prepend(view.el)

  prependChildTo: (view, container) ->
    @renderChild(view)
    $(container).prepend(view.el)

  _leaveChildren: ->
    @children.chain().clone().each (view) ->
      view.leave() if (view.leave)

  _removeFromParent: ->
    @parent._removeChild(@) if @parent

  _removeChild: (view) ->
    @children.splice(@children.indexOf(view), 1)

_.extend App.View, App.Mixins