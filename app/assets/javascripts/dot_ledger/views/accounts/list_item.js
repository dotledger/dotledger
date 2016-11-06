DotLedger.module('Views.Accounts', function () {
  this.ListItem = Backbone.Marionette.ItemView.extend({
    tagName: 'div',

    template: 'accounts/list_item',

    className: 'list-group-item'
  });
});
