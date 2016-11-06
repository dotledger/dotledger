DotLedger.module('Views.Transactions', function () {
  this.Table = Backbone.Marionette.CompositeView.extend({
    template: 'transactions/table',

    childViewContainer: 'tbody',

    getChildView: function () {
      return DotLedger.Views.Transactions.TableRow;
    },

    childViewOptions: function (model, index) {
      return {
        showAccountName: this.options.showAccountName,
        model: model
      };
    },

    initialize: function () {
      this.pagination = DotLedger.Helpers.pagination(this, this.collection);
    },

    templateHelpers: function () {
      return {
        showAccountName: _.bind(function () {
          return !!this.options.showAccountName;
        }, this)
      };
    }
  });
});
