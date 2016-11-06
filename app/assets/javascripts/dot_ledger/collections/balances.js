DotLedger.module('Collections', function () {
  this.Balances = this.Base.extend({
    url: '/api/balances',

    model: DotLedger.Models.Balance
  });
});
