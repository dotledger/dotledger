DotLedger.module('Views.Statistics.ActivityPerCategory', function () {
  this.ListItem = Backbone.Marionette.ItemView.extend({
    template: 'statistics/activity_per_category/list_item',

    className: 'list-group-item',

    events: {
      'click strong.name a': 'search'
    },

    search: function () {
      var params;
      params = {
        category_id: this.model.get('id'),
        date_from: this.model.collection.metadata.date_from,
        date_to: this.model.collection.metadata.date_to,
        page: 1
      };
      DotLedger.navigate.search(params, {
        trigger: true
      });
      return false;
    },

    templateHelpers: function () {
      return {
        progressWidth: _.bind(function () {
          if (this.model.get('goal') * 1 > 0) {
            return (this.model.get('spent') * 1 / this.model.get('goal') * 1) * 100;
          } else {
            if (this.templateHelpers().overGoal()) {
              return 100;
            }
          }
        }, this),
        overGoal: _.bind(function () {
          return this.model.get('spent') * 1 > this.model.get('goal') * 1;
        }, this),
        progressClass: _.bind(function () {
          if (this.templateHelpers().overGoal()) {
            return 'progress-bar-danger';
          } else {
            return 'progress-bar-success';
          }
        }, this)
      };
    }
  });
});
