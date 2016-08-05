class App.Views.Shared.Components.BodyPartBox extends App.View
  template: HandlebarsTemplates['shared/components/body_part_box']
  tagName: 'select'

  events:
    'change' : '_selected'

  initialize: (options) ->
    unless App.reference_body_parts?
      App.reference_body_parts= new App.Collections.BodyPart({}, { url: '/references/body_parts?short=1' })
      App.reference_body_parts.fetch()
    @collection = App.reference_body_parts
    @listenTo(@collection, 'sync', @render)
    @name = if options? && options.name? then options.name else 'body_part'

  params: ->
    options:
      @collection.map (item) ->
        id: item.get('id')
        name: item.get('name')

  renderLayout: ->
    @$el.attr('name', @name)
    @$el.html @template @params()
    @_select()

  render: ->
    @renderLayout()
    return @

  getValue: ->
    return if (@value? && @value > 0) then parseInt(@value) else null

  setValue: (value) ->
    @value = value
    @_select()

  _select: ->
    @$('option[value="'+@value+'"]').attr('selected', 'selected') if @value?

  _selected: ->
    @value = @$el.val()
    @trigger('selected', @getValue())