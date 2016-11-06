DotLedger.module('Views.Statements', function () {
  this.ListItem = Backbone.Marionette.ItemView.extend({
    tagName: 'tr',

    template: 'statements/list_item'
  });
});
