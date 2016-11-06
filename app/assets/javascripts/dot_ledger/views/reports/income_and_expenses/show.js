DotLedger.module('Views.Reports.IncomeAndExpenses', function () {
  this.Show = Backbone.Marionette.LayoutView.extend({
    template: 'reports/income_and_expenses/show',

    regions: {
      filter: '#filter',
      report: '#report'
    }
  });
});
