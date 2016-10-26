class App.Views.References.Exercises.Filter extends App.CompositeView
  template: HandlebarsTemplates['references/exercises/filter']
  className: 'filter'

  renderLayout: ->
    @$el.html @template

  renderEquipmnet: ->
    @equipment_box = new App.Views.Shared.Components.EquipmentBox({className: 'form-control', name: 'filter.equipment'})
    @appendChildTo(@equipment_box, @$('.equipment_box'))
    @listenTo(@equipment_box, 'selected', @filter)

  renderBodyPart: ->
    @body_part_box = new App.Views.Shared.Components.BodyPartBox({className: 'form-control', name: 'filter.body_part'})
    @appendChildTo(@body_part_box, @$('.body_part_box'))
    @listenTo(@body_part_box, 'selected', @filter)

  render: ->
    @renderLayout()
    @renderEquipmnet()
    @renderBodyPart()
    return @

  getFilterData: ->
    equipment: @equipment_box.getValue()
    body_part: @body_part_box.getValue()

  filter: ->
    @trigger('filter', @getFilterData())