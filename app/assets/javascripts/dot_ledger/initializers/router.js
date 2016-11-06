DotLedger.addInitializer(function (options) {
  this.router = new DotLedger.Routers.App();
  this.router.on('route', function () {
    DotLedger.Helpers.Notification.empty();
  });

  Backbone.history.start({
    pushState: true
  });
});
