DotLedger.module('Views.Statistics.ActivityPerCategory', function () {
  this.List = Backbone.Marionette.CompositeView.extend({
    childViewContainer: '.list-group',

    className: 'panel panel-default',

    template: 'statistics/activity_per_category/list',

    getChildView: function () {
      return DotLedger.Views.Statistics.ActivityPerCategory.ListItem;
    },

    templateHelpers: function () {
      return {
        hasActivity: _.bind(function () {
          return this.collection.length > 0;
        }, this),
        spentAmountTotal: _.bind(function () {
          return DotLedger.Helpers.Format.money(this.collection.metadata.total_spent);
        }, this),
        receivedAmountTotal: _.bind(function () {
          return DotLedger.Helpers.Format.money(this.collection.metadata.total_received);
        }, this),
        netAmountTotal: _.bind(function () {
          return DotLedger.Helpers.Format.money(this.collection.metadata.total_net);
        }, this)
      };
    }
  });
});
