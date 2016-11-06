DotLedger.module('Models', function () {
  this.QueryParams = Backbone.Model.extend({
    toString: function () {
      return $.param(this.attributes).replace(/%5B%5D/g, '');
    }
  });
});
