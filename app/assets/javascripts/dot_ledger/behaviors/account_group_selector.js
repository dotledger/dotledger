DotLedger.module('Behaviors', function () {
  this.AccountGroupSelector = Marionette.Behavior.extend({
    initialize: function () {
      // FIXME: This is a hack to make it easier to test.
      if (this.view.options.account_groups) {
        this.account_groups = this.view.options.account_groups;
      } else {
        this.account_groups = new DotLedger.Collections.AccountGroups();
        this.account_groups.fetch();
      }
    },

    defaults: {
      showAnyOption: true,
      showNoneOption: true,
      accountGroupSelect: 'account_group',
      accountGroupAttribute: 'account_group_id'
    },

    onRender: function () {
      this.account_groups.on('sync', _.bind(this.renderAccountGroups, this));
      this.renderAccountGroups();
    },

    renderAccountGroups: function () {
      var $accountGroupSelect, val;
      $accountGroupSelect = this.view.ui[this.options.accountGroupSelect];
      $accountGroupSelect.empty();

      if (this.options.showAnyOption) {
        $accountGroupSelect.append('<option value="">Any</option>');
      }

      if (this.options.showNoneOption) {
        $accountGroupSelect.append('<option value="-1">None</option>');
      }

      this.account_groups.each(function (accountGroup) {
        var $option;
        $option = $("<option value='" + (accountGroup.get('id')) + "'>" + (accountGroup.get('name')) + '</option>');
        $accountGroupSelect.append($option);
      });

      val = this.view.model.get(this.options.accountGroupAttribute);
      val = (val || -1);

      $accountGroupSelect.val(val);
    }
  });
});
