DotLedger.module('Views.Goals', function () {
  this.List = Backbone.Marionette.CompositeView.extend({
    template: 'goals/list',

    getChildView: function () {
      return DotLedger.Views.Goals.ListItem;
    },

    events: {
      'click button.save-all': 'saveAll'
    },

    templateHelpers: function () {
      return {
        categoryTypes: _.bind(function () {
          var types;
          types = _.uniq(this.collection.pluck('category_type'));
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
      listID = 'category-type-' + (s.underscored(childView.model.get('category_type')));
      collectionView.$('div#' + listID).append(childView.el);
    },

    saveAll: function () {
      this.children.call('save');
      DotLedger.Helpers.Notification.success('Goals have been saved.');
    }
  });
});
