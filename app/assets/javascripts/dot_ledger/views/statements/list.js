DotLedger.module('Views.Statements', function () {
  this.List = Backbone.Marionette.CompositeView.extend({
    template: 'statements/list',

    childViewContainer: 'table tbody',

    getChildView: function () {
      return DotLedger.Views.Statements.ListItem;
    },

    initialize: function () {
      return DotLedger.Helpers.pagination(this, this.collection);
    },

    templateHelpers: function () {
      return {
        accountName: _.bind(function () {
          return this.options.account.get('name');
        }, this),
        accountID: _.bind(function () {
          return this.options.account.get('id');
        }, this)
      };
    }
  });
});
