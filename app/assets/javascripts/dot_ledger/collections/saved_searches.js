DotLedger.module('Collections', function () {
  this.SavedSearches = this.Base.extend({
    url: '/api/saved_searches',

    model: DotLedger.Models.SavedSearch
  });
});
