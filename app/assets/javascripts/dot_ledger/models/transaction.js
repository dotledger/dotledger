DotLedger.module('Models', function () {
  this.Transaction = this.Base.extend({
    urlRoot: '/api/transaction'
  });
});
