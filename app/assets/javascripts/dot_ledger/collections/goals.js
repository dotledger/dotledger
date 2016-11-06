DotLedger.module('Collections', function () {
  this.Goals = this.Base.extend({
    url: '/api/goals',

    model: DotLedger.Models.Goal
  });
});
