DotLedger.module('Views.Statistics.ActivityPerCategoryType', function () {
  this.ListItem = Backbone.Marionette.ItemView.extend({
    template: 'statistics/activity_per_category_type/list_item',

    className: 'list-group-item',

    templateHelpers: function () {
      var self = this;
      return {
        searchPath: function () {
          var params;
          params = {
            date_from: self.model.collection.metadata.date_from,
            date_to: self.model.collection.metadata.date_to,
            page: 1
          };
          var type = self.model.get('type');
          if (type === 'Uncategorised') {
            params.unsorted = true;
          }else {
            params.category_type = type;
          }

          return DotLedger.path.search(params);
        }
      };
    }
  });
});
