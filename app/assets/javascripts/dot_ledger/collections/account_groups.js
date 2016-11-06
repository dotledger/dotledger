DotLedger.module('Collections', function () {
  this.AccountGroups = this.Base.extend({
    url: '/api/account_groups',

    model: DotLedger.Models.AccountGroup
  });
});
