DotLedger.module('Views.Search', function () {
  this.Search = Backbone.Marionette.LayoutView.extend({
    template: 'search/search',

    regions: {
      searchFilters: '#search-filters',
      searchSummary: '#search-summary',
      searchResults: '#search-results'
    }
  });
});
