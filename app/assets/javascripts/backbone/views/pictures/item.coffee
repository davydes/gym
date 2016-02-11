class App.Views.Pictures.Item extends App.View

  template: HandlebarsTemplates['pictures/item']

  tagName: 'tr'

  id: ->
    @model.id

  events:
    'click a.delete' : 'destroy'
    'click a.edit'   : 'edit'

  render: ->
    @$el.html @template @model.toJSON()
    return @

  replaceWith: (view) ->
    @stopListening()
    $(@el).replaceWith(view.el)
    view.render()

  destroy: ->
    @model.destroy
      wait: true
      error: =>
        messages.notice 'Can not delete!'
      success: =>
        @remove()
        messages.notice 'Deleted successfully.'

  edit: ->
    @replaceWith(new App.Views.Pictures.Edit(model: @model))
