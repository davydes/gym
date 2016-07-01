class App.Views.ErrorView extends App.View
  initialize: (options) ->
    @errors = options.errors || ( new App.ErrorList() )

  clearPreviousErrors: ->
    @$('.form-group.has-error').each ->
      $('.help-block', @).html('')
      $(@).removeClass('has-error')

  render: ->
    @clearPreviousErrors()
    @errors.each (messages, field) =>
      if (messages.length > 0)
        input = @fieldFor(field)
        input.closest('.form-group').addClass('has-error').find('.help-block').html(messages.join(' & '))

  fieldFor: (attribute) ->
    @$el.find('[name="' + attribute + '"]')
    #todo: need to make the finder method more universal
