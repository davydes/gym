class App.Views.Pictures.Edit extends App.View

  template: HandlebarsTemplates['pictures/edit']

  tagName: 'tr'

  id: ->
    @model.id

  events:
    'click a.save'   : 'save'
    'click a.cancel' : 'cancel'

  render: ->
    @$el.html @template @model.toJSON()
    return @

  replaceWith: (view) ->
    @stopListening()
    $(@el).replaceWith(view.el);
    view.render();

  cancel: ->
    @replaceWith(new App.Views.Pictures.Item(model: @model))

  save: ->
    @model.save
      name: @$el.find('input[name=\'name\']').val(),
        patch: true
        wait: true
        error: (model, response) =>
          errors = new App.ErrorList(response)
          view = new App.Views.ErrorView
            el: @el
            errors: errors
          .render()
          messages.notice 'Can not save!'
        success: =>
          messages.notice 'Changed successfully.'
          @replaceWith(new App.Views.Pictures.Item(model: @model))