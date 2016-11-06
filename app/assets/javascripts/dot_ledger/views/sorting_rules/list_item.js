DotLedger.module('Views.SortingRules', function () {
  this.ListItem = Backbone.Marionette.ItemView.extend({
    tagName: 'tr',

    template: 'sorting_rules/list_item',

    templateHelpers: function () {
      return {
        flag: _.bind(function () {
          if (this.model.get('review')) {
            return 'Review';
          } else {
            return '';
          }
        }, this)
      };
    },

    ui: {
      'delete': 'a.delete-sorting-rule'
    },

    events: {
      'click @ui.delete': 'confirmDelete'
    },

    confirmDelete: function (e) {
      var confirmation;
      e.preventDefault();

      confirmation = new DotLedger.Views.Application.ConfirmationModal({
        body: 'Are you sure you want to delete ' + (this.model.get('contains')) + '?'
      });

      DotLedger.modalRegion.show(confirmation);

      confirmation.on('confirm', _.bind(function () {
        this.model.destroy({
          wait: true,
          success: function (model, response, options) {
            DotLedger.Helpers.Notification.success('Deleted ' + (model.get('contains')) + '.');
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
