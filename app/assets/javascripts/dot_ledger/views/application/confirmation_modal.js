DotLedger.module('Views.Application', function () {
  this.ConfirmationModal = Backbone.Marionette.ItemView.extend({
    template: 'application/confirmation_modal',

    className: 'modal',

    ui: {
      confirm: '.confirm',
      close: 'button.close',
      cancel: '.cancel'
    },

    events: {
      'click @ui.confirm': 'confirm',
      'click @ui.close': 'close',
      'click @ui.cancel': 'close'
    },

    confirm: function () {
      this.trigger('confirm');
      this.destroy();
    },

    close: function () {
      this.destroy();
    },

    templateHelpers: function () {
      return {
        title: _.bind(function () {
          return this.options.title || 'Are you sure?';
        }, this),
        body: _.bind(function () {
          return this.options.body || 'Are you sure you want to continue?';
        }, this),
        confirm: _.bind(function () {
          return this.options.confirm || 'Confirm';
        }, this),
        cancel: _.bind(function () {
          return this.options.cancel || 'Cancel';
        }, this)
      };
    }
  });
});
