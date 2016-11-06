DotLedger.module('Models', function () {
  this.Payment = this.Base.extend({
    urlRoot: '/api/payments'
  });
});
