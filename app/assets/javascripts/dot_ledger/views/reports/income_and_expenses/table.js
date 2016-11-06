DotLedger.module('Views.Reports.IncomeAndExpenses', function () {
  this.Table = Backbone.Marionette.CompositeView.extend({
    template: 'reports/income_and_expenses/table',

    getChildView: function () {
      return DotLedger.Views.Reports.IncomeAndExpenses.TableRow;
    },

    childViewOptions: function (model, index) {
      return {
        metadata: this.collection.metadata
      };
    },

    templateHelpers: function () {
      return {
        spentAmountTotal: _.bind(function () {
          return DotLedger.Helpers.Format.money(this.collection.metadata.total_spent);
        }, this),
        receivedAmountTotal: _.bind(function () {
          return DotLedger.Helpers.Format.money(this.collection.metadata.total_received);
        }, this),
        spentAmountSubTotal: _.bind(function (label) {
          var amount;
          amount = this.collection.chain().select(function (row) {
            return row.get('type') === label;
          }).map(function (row) {
            return row.get('spent');
          }).reduce(function (total, amount) {
            return total + parseFloat(amount);
          }, 0.0).value();
          return DotLedger.Helpers.Format.money(amount);
        }, this),
        receivedAmountSubTotal: _.bind(function (label) {
          var amount;
          amount = this.collection.chain().select(function (row) {
            return row.get('type') === label;
          }).map(function (row) {
            return row.get('received');
          }).reduce(function (total, amount) {
            return total + parseFloat(amount);
          }, 0.0).value();
          return DotLedger.Helpers.Format.money(amount);
        }, this),
        categoryTypes: _.bind(function () {
          var types;
          types = _.uniq(this.collection.pluck('type'));
          return _.map(types, function (type) {
            return {
              label: type,
              id: 'category-type-' + (s.underscored(type))
            };
          });
        }, this)
      };
    },

    attachHtml: function (collectionView, childView, index) {
      var listID;
      listID = 'category-type-' + (s.underscored(childView.model.get('type')));
      collectionView.$('#' + listID).append(childView.el);
    }
  });
});
