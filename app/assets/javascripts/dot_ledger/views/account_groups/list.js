DotLedger.module('Views.AccountGroups', function () {
  this.List = Backbone.Marionette.CompositeView.extend({
    template: 'account_groups/list',

    getChildView: function () {
      return DotLedger.Views.AccountGroups.ListItem;
    },

    childViewContainer: 'table tbody'
  });
});
