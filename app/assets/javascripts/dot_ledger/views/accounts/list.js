DotLedger.module('Views.Accounts', function () {
  this.List = Backbone.Marionette.CompositeView.extend({
    className: 'panel panel-default',

    template: 'accounts/list',

    getChildView: function () {
      return DotLedger.Views.Accounts.ListItem;
    },

    attachHtml: function (collectionView, childView, index) {
      var listID;
      listID = 'account_group_' + (childView.model.get('account_group_id'));
      collectionView.$('div#' + listID).append(childView.el);
    },

    templateHelpers: function () {
      return {
        accountGroups: _.bind(function () {
          var accountGroups;
          accountGroups = {};
          this.collection.forEach(function (account) {
            accountGroups[account.get('account_group_id')] = account.get('account_group_name');
          });

          return _.map(accountGroups, _.bind(function (name, id) {
            var net;
            net = this.collection.chain().select(function (account) {
              return account.get('account_group_id') === id;
            }).map(function (account) {
              return account.get('balance');
            }).reduce(function (total, balance) {
              return total + parseFloat(balance);
            }, 0.0).value();
            return {
              label: name,
              id: 'account_group_' + id,
              net: net
            };
          }, this));
        }, this),
        totalCash: _.bind(function () {
          var balances;
          balances = this.collection.map(function (account) {
            if (account.get('balance') > 0) {
              return account.get('balance');
            } else {
              return 0;
            }
          });
          return _.reduce(balances, function (b, total) {
            return parseFloat(total) + parseFloat(b);
          }, 0);
        }, this),
        totalDebt: _.bind(function () {
          var balances;
          balances = this.collection.map(function (account) {
            if (account.get('balance') < 0) {
              return account.get('balance');
            } else {
              return 0;
            }
          });
          return -_.reduce(balances, function (b, total) {
            return parseFloat(total) + parseFloat(b);
          }, 0);
        }, this)
      };
    }
  });
});
