DotLedger.addInitializer ->
  $(document).ajaxStart ->
    DotLedger.Helpers.Loading.start()

  $(document).ajaxStop ->
    DotLedger.Helpers.Loading.stop()
