#= require i18n/translations
#= require jquery
#= require jquery_ujs
#= require underscore
#= require backbone
#= require handlebars
#= require twitter/bootstrap
#= require bootstrap-multiselect
#= require bootstrap-datepicker/core
#= require bootstrap-datepicker/locales/bootstrap-datepicker.ru.js
#= require backbone/app
#= require_tree .

$.fn.renderFormErrors = (errors) ->
  @clearPreviousErrors()
  model = @data('model')
  $.each errors, (field, messages) ->
    if (messages.length > 0)
      input = $('#'+model+'_'+field)
      input.closest('.form-group').addClass('has-error').find('.help-block').html(messages.join(' & '))

$.fn.clearPreviousErrors = ->
  $('.form-group.has-error', this).each ->
    $('.help-block', $(@)).html('')
    $(@).removeClass('has-error')

$ ->
  $(document).bind 'ajaxError', 'form[data-remote]', (event, jqxhr) ->
    $(event.data).renderFormErrors($.parseJSON(jqxhr.responseText))
