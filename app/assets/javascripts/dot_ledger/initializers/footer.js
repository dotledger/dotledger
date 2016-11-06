DotLedger.addInitializer(function (options) {
  this.footer = new DotLedger.Views.Application.Footer();
  DotLedger.footerRegion.show(this.footer);
});
