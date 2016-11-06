DotLedger.addInitializer(function () {
  $(document).ajaxError(function (event, jqXHR, ajaxSettings, thrownError) {
    if (jqXHR.status === 0) {
      DotLedger.Helpers.Notification.danger('Could not connect to server.');
    }
  });
});
