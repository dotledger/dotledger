DotLedger.addInitializer(function () {
  $(document).ajaxStart(function () {
    DotLedger.Helpers.Loading.start();
  });

  $(document).ajaxStop(function () {
    DotLedger.Helpers.Loading.stop();
  });
});
