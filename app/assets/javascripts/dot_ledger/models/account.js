DotLedger.module('Models', function () {
  this.Account = this.Base.extend({
    urlRoot: '/api/accounts'
  });
});
