DotLedger.module('Collections', function () {
  this.Tags = this.Base.extend({
    url: '/api/tags',

    model: DotLedger.Models.Tag
  });
});
