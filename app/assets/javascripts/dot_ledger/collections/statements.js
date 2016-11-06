DotLedger.module('Collections', function () {
  this.Statements = this.Base.extend({
    url: '/api/statements',

    model: DotLedger.Models.Statement
  });
});
