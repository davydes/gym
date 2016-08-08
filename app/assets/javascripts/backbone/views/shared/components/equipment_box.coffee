class App.Views.Shared.Components.EquipmentBox extends App.View
  template: HandlebarsTemplates['shared/components/equipment_box']
  tagName: 'select'

  events:
    'change' : '_selected'

  initialize: (options) ->
    unless App.reference_equipments?
      App.reference_equipments = new App.Collections.Equipment({}, { url: '/references/equipments' })
      App.reference_equipments.fetch()
    @collection = App.reference_equipments
    @listenTo(@collection, 'sync', @render)
    @name = if options? && options.name? then options.name else 'equipment'

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