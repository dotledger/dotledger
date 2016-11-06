DotLedger.module('Views.Reports.IncomeAndExpenses', function () {
  this.TableRow = Backbone.Marionette.ItemView.extend({
    template: 'reports/income_and_expenses/table_row',

    tagName: 'tr',

    templateHelpers: function () {
      return {
        searchLinkHref: _.bind(function () {
          var params;
          params = {
            date_from: this.options.metadata.date_from,
            date_to: this.options.metadata.date_to,
            category_id: this.model.get('id'),
            page: 1
          };
          return DotLedger.path.search(params);
        }, this),
        spentAmount: _.bind(function () {
          if (this.model.get('spent') !== '0.0') {
            return DotLedger.Helpers.Format.money(this.model.get('spent'));
          }
        }, this),
        receivedAmount: _.bind(function () {
          if (this.model.get('received') !== '0.0') {
            return DotLedger.Helpers.Format.money(this.model.get('received'));
          }
        }, this)
      };
    }
  });
});
