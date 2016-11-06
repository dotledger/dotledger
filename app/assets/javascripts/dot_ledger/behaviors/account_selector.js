DotLedger.module('Behaviors', function () {
  this.AccountsSelector = Marionette.Behavior.extend({
    initialize: function () {
      // FIXME: This is a hack to make it easier to test.
      if (this.view.options.accounts) {
        this.accounts = this.view.options.accounts;
      } else {
        this.accounts = new DotLedger.Collections.Accounts();
        this.accounts.fetch();
      }
    },

    defaults: {
      showAnyOption: true,
      accountSelect: 'account',
      accountAttribute: 'account_id'
    },

    onRender: function () {
      this.accounts.on('sync', _.bind(this.renderAccounts, this));
      this.renderAccounts();
    },

    renderAccounts: function () {
      var $accountSelect;
      $accountSelect = this.view.ui[this.options.accountSelect];
      $accountSelect.empty();

      if (this.options.showAnyOption) {
        $accountSelect.append('<option value="">Any</option>');
      }

      _.each(this.accounts.groupBy('account_group_name'), function (accounts, label) {
        var $optgroup;

        if (label === 'null') {
          label = 'Other';
        }

        $optgroup = $("<optgroup label='" + label + "'></optgroup>");

        _.each(accounts, function (account) {
          var $option = $("<option value='" + (account.get('id')) + "'>" + (account.get('name')) + '</option>');
          $optgroup.append($option);
        });

        $accountSelect.append($optgroup);
      });

      $accountSelect.val(this.view.model.get(this.options.accountAttribute));
    }
  });
});
