class App.Views.Shared.Progress extends App.View
  template: HandlebarsTemplates['shared/progress']
  className: 'progress'

  hide: ->
    @$el.addClass 'hide'

  show: ->
    @$el.removeClass 'hide'

  progress: (prc) ->
    @$('.progress-bar')
    .removeClass 'progress-bar-striped active'
    .css 'width', prc+'%'
    .attr 'aria-valuenow', prc
    .html prc+'%'

  infinite: (text) ->
    @progress 100
    @$('.progress-bar')
    .addClass 'progress-bar-striped active'
    .html text

  render: ->
    @$el.html @template
    return @