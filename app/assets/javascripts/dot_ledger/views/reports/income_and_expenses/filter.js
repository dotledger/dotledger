DotLedger.module('Views.Reports.IncomeAndExpenses', function () {
  this.Filter = Backbone.Marionette.ItemView.extend({
    template: 'reports/income_and_expenses/filter',

    className: 'nav nav-small nav-pills',

    tagName: 'ul',

    events: {
      'click .period a': 'clickPeriod'
    },

    onRender: function () {
      this.$el.find('.period.period-' + (this.model.get('period')) + '-days').addClass('active');
    },

    clickPeriod: function (event) {
      this.model.set('period', $(event.target).data('period'));
      return false;
    }
  });
});
