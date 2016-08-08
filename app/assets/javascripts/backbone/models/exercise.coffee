class App.Models.Exercise extends App.Model

  initialize: ->
    @listenTo(@,'change:equipments', @parseEquipments)
    @parseEquipments()
    @parseBodyParts()

  parseEquipments: ->
    @equipments = new App.Collections.Equipment(@get('equipments'))

  parseBodyParts: ->
    @body_parts = new App.Collections.Equipment(@get('body_parts'))