#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require bootstrap-multiselect
#= require bootstrap-datepicker/core
#= require bootstrap-datepicker/locales/bootstrap-datepicker.ru.js
#= require_tree .

$.fn.renderFormErrors = (errors) ->
  this.clearPreviousErrors()
  model = this.data('model')
  $.each errors, (field, messages) ->
    if (messages.length > 0)
      input = $('#'+model+'_'+field)
      input.closest('.form-group').addClass('has-error').find('.help-block').html(messages.join(' & '))

$.fn.clearPreviousErrors = ->
  $('.form-group.has-error', this).each ->
    $('.help-block', $(this)).html('');
    $(this).removeClass('has-error');

$ ->
  $(document).bind 'ajaxError', 'form[data-remote]', (event, jqxhr) ->
    $(event.data).renderFormErrors($.parseJSON(jqxhr.responseText));