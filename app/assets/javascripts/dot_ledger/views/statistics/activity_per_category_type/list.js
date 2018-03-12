DotLedger.module('Views.Statistics.ActivityPerCategoryType', function () {
  this.List = Backbone.Marionette.CompositeView.extend({
    childViewContainer: '.list-group',

    className: 'panel panel-default',

    template: 'statistics/activity_per_category_type/list',

    getChildView: function () {
      return DotLedger.Views.Statistics.ActivityPerCategoryType.ListItem;
    },

    ui: {
      pieGraph: '#activity-per-category-type-pie'
    },

    templateHelpers: function () {
      return {
        hasTransactions: _.bind(function () {
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
    },

    pieGraphData: function () {
      return this.collection.map(function (activity) {
        return {
          label: activity.get('type'),
          data: Math.abs(activity.get('net'))
        };
      });
    },

    pieGraphOptions: function () {
      return {
        series: {
          pie: {
            show: true
          }
        },
        legend: {
          show: false
        }
      };
    },

    renderPieGraph: function () {
      if (this.isRendered) {
        if (this.collection.length > 0) {
          $.plot(this.ui.pieGraph, this.pieGraphData(), this.pieGraphOptions());
        }
      }
    },

    onRender: function () {
      this.collection.on('sync', _.bind(function () {
        this.renderPieGraph();
      }, this));
      _.defer(_.bind(function () {
        this.renderPieGraph();
      }, this));
    }
  });
});
