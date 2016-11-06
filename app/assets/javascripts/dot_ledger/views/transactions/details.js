DotLedger.module('Views.Transactions', function () {
  this.Details = Backbone.Marionette.ItemView.extend({
    template: 'transactions/details',

    className: 'modal'
  });
});
