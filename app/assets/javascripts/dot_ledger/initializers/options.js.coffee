DotLedger.addInitializer (options)->
  $.ajax
    url: "/api/options"
    type: 'GET'
    success: (response)->
      window.DotLedgerData = response
      DotLedger.trigger 'options:change', response
