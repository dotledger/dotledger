DotLedger.module('Views.AccountGroups', function () {
  this.ListItem = Backbone.Marionette.ItemView.extend({
    tagName: 'tr',

    template: 'account_groups/list_item',

    ui: {
      'delete': 'a.delete-account-group'
    },

    events: {
      'click @ui.delete': 'confirmDelete'
    },

    confirmDelete: function (e) {
      e.preventDefault();

      var confirmation = new DotLedger.Views.Application.ConfirmationModal({
        body: 'Are you sure you want to delete ' + (this.model.get('name')) + '?'
      });

      DotLedger.modalRegion.show(confirmation);
      confirmation.on('confirm', _.bind(function () {
        this.model.destroy({
          wait: true,
          success: function (model, response, options) {
            DotLedger.Helpers.Notification.success('Deleted ' + (model.get('name')) + '.');
          },
          error: function (model, response, options) {
            model.serverSideErrors(model, response, options);
            DotLedger.Helpers.Notification.danger(model.validationError.base[0]);
          }
        });
      }, this));
    }
  });
});
