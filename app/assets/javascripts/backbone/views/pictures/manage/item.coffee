class App.Views.Pictures.Manage.Item extends App.View
  template: HandlebarsTemplates['pictures/manage/item']
  tagName: 'tr'

  id: ->
    @model.id

  events:
    'click a.delete' : 'destroyConfirmation'

  render: ->
    el = @template @model.toJSON()
    @$el.html el
    @whileInProcessing() if @model.get('image_processing')
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

  whileInProcessing: ->
    @$el.find('img').attr('src', image_path('processing.gif'))
    setTimeout(
      timer = =>
        @model.fetch(wait: true)
        if @model.get('image_processing')
          setTimeout timer, 2000
        else
          @$el.find('img').attr('src', @model.get('thumb'))
      2000
    )

  leave: ->
    @remove()