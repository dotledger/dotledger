DotLedger.module('Views.Accounts', function () {
  this.ListItemArchived = Backbone.Marionette.ItemView.extend({
    tagName: 'div',

    template: 'accounts/list_item_archived',

    className: 'list-group-item',

    ui: {
      'unarchive': 'a.unarchive'
    },

    events: {
      'click @ui.unarchive': 'unarchiveAccount'
    },

    unarchiveAccount: function () {
      this.model.save({
        archived: 'false'
      },
        {
          success: function (model, response, options) {
            DotLedger.accounts.fetch();
            DotLedger.navigate.root({}, {
              trigger: true
            });
          },
          error: function (model, response, options) {
            model.serverSideErrors(model, response, options);
            DotLedger.Helpers.Notification.danger(model.validationError.base[0]);
          }
        });
    }
  });
});
