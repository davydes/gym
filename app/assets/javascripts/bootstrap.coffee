$ ->
  $("a[rel~=popover], .has-popover").popover();
  $("a[rel~=tooltip], .has-tooltip").tooltip();
  $('[data-toggle=offcanvas]').click ->
    $('.row-offcanvas').toggleClass('active')
