DotLedger.module('Views.Categories', function () {
  this.ListItem = Backbone.Marionette.ItemView.extend({
    tagName: 'div',

    className: 'list-group-item',

    template: 'categories/list_item',

    ui: {
      'delete': 'a.delete-category'
    },

    events: {
      'click @ui.delete': 'confirmDelete'
    },

    confirmDelete: function (e) {
      var confirmation;
      e.preventDefault();
      confirmation = new DotLedger.Views.Application.ConfirmationModal({
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
