DotLedger.module('Views.Payments', function () {
  this.ListItem = Backbone.Marionette.ItemView.extend({
    tagName: 'tr',

    template: 'payments/list_item',

    templateHelpers: function () {
      return {
        spendAmount: _.bind(function () {
          if (this.model.get('type') === 'Spend') {
            return DotLedger.Helpers.Format.money(this.model.get('amount'));
          }
        }, this),
        receiveAmount: _.bind(function () {
          if (this.model.get('type') === 'Receive') {
            return DotLedger.Helpers.Format.money(this.model.get('amount'));
          }
        }, this)
      };
    }
  });
});
