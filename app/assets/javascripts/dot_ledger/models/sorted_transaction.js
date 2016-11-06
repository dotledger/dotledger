DotLedger.module('Models', function () {
  this.SortedTransaction = this.Base.extend({
    urlRoot: '/api/sorted_transactions'
  });
});
