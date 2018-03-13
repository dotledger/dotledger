DotLedger.module('Views.SavedSearches', function () {
  this.List = Backbone.Marionette.CompositeView.extend({
    template: 'saved_searches/list',

    getChildView: function () {
      return DotLedger.Views.SavedSearches.ListItem;
    },

    childViewContainer: 'table tbody',

    templateHelpers: function () {
      return {
        hasSavedSearches: _.bind(function () {
          return this.collection.length > 0;
        }, this),
      }
    }
  });
});
