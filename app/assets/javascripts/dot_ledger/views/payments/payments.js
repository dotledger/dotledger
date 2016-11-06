DotLedger.module('Views.Payments', function () {
  this.Payments = Backbone.Marionette.LayoutView.extend({
    template: 'payments/payments',

    regions: {
      graph: '#graph',
      payments: '#payments'
    }
  });
});
