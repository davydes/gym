@messages =
  message: (type, msg) ->
    $('.alert[role=\'alert\']', $('#content')).each ->
      @remove()
    div = document.createElement('div')
    $(div).addClass('alert')
    switch type
      when 'info' then $(div).addClass('alert-info')
      when 'danger' then $(div).addClass('alert-danger')
      when 'success' then $(div).addClass('alert-success')
      when 'warning' then $(div).addClass('alert-warning')
      else $(div).addClass('alert-primary')
    $(div).attr('role', 'alert')
    $(div).text(msg)
    $(div).prependTo('#content')
    $(div).delay(3000).fadeOut
      complete: ->
        @remove()

  info: (msg) ->
    messages.message('info', msg)

  danger: (msg) ->
    messages.message('danger', msg)

  success: (msg) ->
    messages.message('success', msg)

  warning: (msg) ->
    messages.message('warning', msg)