DotLedger.module('Collections', function () {
  this.Payments = this.Base.extend({
    url: '/api/payments',

    model: DotLedger.Models.Payment
  });
});
