DotLedger.module('Collections', function () {
  this.Categories = this.Base.extend({
    url: '/api/categories',

    model: DotLedger.Models.Category
  });
});
