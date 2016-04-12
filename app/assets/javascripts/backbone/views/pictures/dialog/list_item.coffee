class App.Views.Pictures.Dialog.ListItem extends App.View
  template: HandlebarsTemplates['pictures/dialog/list_item']

  events:
    'click' : 'onClick'

  id: ->
    @model.id

  render: ->
    @$el.html @template @model.toJSON()
    return @

  onClick: ->
    @trigger 'clickPicture', @id()

  leave: ->
    @remove()