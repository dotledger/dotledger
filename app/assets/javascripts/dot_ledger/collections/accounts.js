DotLedger.module('Collections', function () {
  this.Accounts = this.Base.extend({
    url: '/api/accounts',

    model: DotLedger.Models.Account
  });
});
