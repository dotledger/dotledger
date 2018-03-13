DotLedger.module('Views.Accounts', function () {
  this.List = Backbone.Marionette.LayoutView.extend({
    template: 'accounts/list',

    regions: {
      activeAccounts: '#active-accounts',
      archivedAccounts: '#archived-accounts'
    }
  });
});
