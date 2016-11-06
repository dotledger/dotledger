DotLedger.addInitializer(function (options) {
  $.ajax({
    url: '/api/options',
    type: 'GET',
    success: function (response) {
      window.DotLedgerData = response;
      DotLedger.trigger('options:change', response);
    }
  });
});
