DotLedger.module('Views.Accounts', function () {
  this.Show = Backbone.Marionette.LayoutView.extend({
    template: 'accounts/show',

    initialize: function (options) {
      this.params = options.params;
    },

    regions: {
      transactions: '#transactions',
      graph: '#graph'
    },

    ui: {
      'archive': 'a.archive'
    },

    events: {
      'click a[data-tab]': 'clickTab',
      'click @ui.archive': 'confirmArchive'
    },

    setActiveTab: function () {
      this.$el.find('a[data-tab]').parent().removeClass('active');
      this.$el.find("a[data-tab='" + (this.params.get('tab')) + "']").parent().addClass('active');
    },

    clickTab: function (event) {
      event.preventDefault();
      this.params.set({
        tab: $(event.target).data('tab')
      });
      this.setActiveTab();
    },

    onRender: function () {
      this.setActiveTab();
    },

    confirmArchive: function (e) {
      var confirmation;
      e.preventDefault();
      confirmation = new DotLedger.Views.Application.ConfirmationModal({
        body: 'Are you sure you want to archive this account?'
      });

      DotLedger.modalRegion.show(confirmation);

      confirmation.on('confirm', _.bind(function () {
        this.model.save({
          archived: 'true'
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
      }, this));
    }
  });
});
