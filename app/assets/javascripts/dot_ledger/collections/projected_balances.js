DotLedger.module('Collections', function () {
  this.ProjectedBalances = this.Base.extend({
    url: '/api/balances/projected',

    model: DotLedger.Models.Balance
  });
});
