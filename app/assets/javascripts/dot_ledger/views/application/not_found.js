DotLedger.module('Views.Application', function () {
  this.NotFound = Backbone.Marionette.ItemView.extend({
    template: 'application/not_found'
  });
});
