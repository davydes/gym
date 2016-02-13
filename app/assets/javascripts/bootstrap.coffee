$ ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $('[data-toggle=offcanvas]').click ->
    $('.row-offcanvas').toggleClass('active')

  $(".alert-3s").delay(3000).fadeOut
    complete: ->
      $(@).remove()
