class App.Views.Pictures.Item extends App.View
  template: HandlebarsTemplates['pictures/item']
  tagName: 'tr'

  id: ->
    @model.id

  events:
    'click a.delete' : 'destroyConfirmation'
    'click a.edit'   : 'edit'

  render: ->
    @$el.html @template @model.toJSON()
    return @

  replaceWith: (view) ->
    @stopListening()
    $(@el).replaceWith(view.el)
    view.render()

  destroyConfirmation: ->
    @destroy() if confirm( I18n.t 'pictures.messages.confirm_delete', { name: @model.get('name') } )

  destroy: ->
    @model.destroy
      wait: true
      error: =>
        messages.danger I18n.t 'pictures.messages.delete_unsuccessful'
      success: =>
        @remove()
        messages.info I18n.t 'pictures.messages.delete_successful'

  edit: ->
    @replaceWith(new App.Views.Pictures.Edit(model: @model))
