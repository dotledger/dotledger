DotLedger.module('Models', function () {
  this.Balance = this.Base.extend({
    urlRoot: '/api/balances'
  });
});
