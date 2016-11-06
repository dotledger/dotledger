DotLedger.module('Views.Application', function () {
  this.Notification = Backbone.Marionette.LayoutView.extend({
    template: 'application/notification',

    ui: {
      close: 'button.close'
    },

    events: {
      'click button.close': 'remove'
    }
  });
});
