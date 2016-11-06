DotLedger.module('Views.Categories', function () {
  this.List = Backbone.Marionette.CompositeView.extend({
    template: 'categories/list',

    getChildView: function () {
      return DotLedger.Views.Categories.ListItem;
    },

    templateHelpers: function () {
      return {
        categoryTypes: _.bind(function () {
          var types;
          types = _.uniq(this.collection.pluck('type'));
          return _.map(types, function (type) {
            return {
              label: type,
              id: 'category-type-' + (s.underscored(type))
            };
          });
        }, this)
      };
    },

    attachHtml: function (collectionView, childView, index) {
      var listID;
      listID = 'category-type-' + (s.underscored(childView.model.get('type')));
      collectionView.$('div#' + listID).append(childView.el);
    }
  });
});
