class App.Views.Pictures.Edit extends App.View
  template: HandlebarsTemplates['pictures/edit']
  tagName: 'tr'

  id: ->
    @model.id

  events:
    'click a.save'   : 'save'
    'keyup input'    : 'keyupHandler'
    'click a.cancel' : 'cancel'

  render: ->
    @$el.html @template @model.toJSON()
    return @

  replaceWith: (view) ->
    @stopListening()
    $(@el).replaceWith(view.el)
    view.render()

  cancel: ->
    @replaceWith(new App.Views.Pictures.Item(model: @model))

  save: ->
    @model.save
      name: @$el.find('input[name=\'name\']').val(),
        patch: true
        wait: true
        error: (model, response) =>
          ev = new App.Views.ErrorView
            el: @el
            errors: new App.ErrorList(response)
          ev.render()
          messages.danger I18n.t 'pictures.messages.save_unsuccessful'
        success: =>
          messages.success I18n.t 'pictures.messages.save_successful'
          @replaceWith(new App.Views.Pictures.Item(model: @model))

  keyupHandler: (e) ->
    @save() if e.which == 13
