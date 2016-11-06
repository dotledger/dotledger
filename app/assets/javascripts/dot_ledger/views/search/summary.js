DotLedger.module('Views.Search', function () {
  this.Summary = Backbone.Marionette.ItemView.extend({
    template: 'search/summary',

    onRender: function () {
      this.collection.on('sync', this.render);
    },

    templateHelpers: function () {
      return {
        totalCount: _.bind(function () {
          return this.collection.pagination && this.collection.pagination.total_items;
        }, this),
        totalSpent: _.bind(function () {
          return this.collection.metadata && this.collection.metadata.total_spent;
        }, this),
        totalReceived: _.bind(function () {
          return this.collection.metadata && this.collection.metadata.total_received;
        }, this)
      };
    }
  });
});
