DotLedger.module('Collections', function () {
  this.Transactions = this.Base.extend({
    url: '/api/transactions',

    model: DotLedger.Models.Transaction
  });
});
