class App.Views.Journals.Items.Item extends App.CompositeView
  template: HandlebarsTemplates['journals/items/item']
  tagName: 'tr'

  events:
    'click a.delete' : 'destroy'
    'click a.detail' : 'show'
    'click a.edit' : 'edit'

  initialize: (options) ->
    @id = @model.get('id')
    @listenTo @model, "change", @render

  params: ->
    id: @model.get('id')
    executed_at: moment.unix(@model.get('executed_at')).format('YYYY.MM.DD HH:mm')
    count: @model.workout.items.length
    workout_name: @model.workout.get('name')

  render: ->
    @$el.html @template @params()
    return @

  show: ->
    app.navigate "show/#{@id}", trigger: true

  edit: ->
    app.navigate "edit/#{@id}", trigger: true

  destroy: ->
    if confirm( I18n.t 'journal.messages.confirm_delete', { name: @model.workout.get('name') } )
      @model.destroy
        wait: true
        error: =>
          messages.danger I18n.t 'journal.messages.delete_unsuccessful'
        success: =>
          @leave()
          messages.info I18n.t 'journal.messages.delete_successful'