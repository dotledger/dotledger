DotLedger.addInitializer(function (options) {
  this.accounts = new DotLedger.Collections.Accounts();
  this.accounts.fetch();
  this.nav = new DotLedger.Views.Application.MainNav({
    accounts: this.accounts
  });

  DotLedger.headerRegion.show(this.nav);
});
