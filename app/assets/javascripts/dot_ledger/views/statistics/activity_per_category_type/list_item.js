DotLedger.module('Views.Statistics.ActivityPerCategoryType', function () {
  this.ListItem = Backbone.Marionette.ItemView.extend({
    template: 'statistics/activity_per_category_type/list_item',

    className: 'list-group-item'
  });
});
