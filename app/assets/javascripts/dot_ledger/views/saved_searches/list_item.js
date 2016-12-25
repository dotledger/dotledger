DotLedger.module('Views.SavedSearches', function () {
  this.ListItem = Backbone.Marionette.ItemView.extend({
    tagName: 'tr',

    template: 'saved_searches/list_item',

    ui: {
      'delete': 'a.delete-saved-search'
    },

    events: {
      'click @ui.delete': 'confirmDelete'
    },

    templateHelpers: function () {
      return {
        searchPath: _.bind(function () {
          return _.compact(["/search?page=1", DotLedger.Helpers.Search(_.omit(this.model.attributes, 'id', 'date_from', 'date_to')).toString()]).join("&");
        }, this)
      }
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
