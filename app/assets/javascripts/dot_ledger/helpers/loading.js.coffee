DotLedger.module 'Helpers', ->
  @Loading =
    start: ->
      DotLedger.container.addClass('loading')
    stop: ->
      DotLedger.container.removeClass('loading')
