DotLedger.module('Collections', function () {
  this.SortingRules = this.Base.extend({
    url: '/api/sorting_rules',

    model: DotLedger.Models.SortingRule
  });
});
