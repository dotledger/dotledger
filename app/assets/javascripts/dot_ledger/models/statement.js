DotLedger.module('Models', function () {
  this.Statement = this.Base.extend({
    urlRoot: '/api/statements'
  });
});
