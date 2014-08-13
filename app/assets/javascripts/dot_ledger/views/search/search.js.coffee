DotLedger.module 'Views.Search', ->
  class @Search extends Backbone.Marionette.LayoutView
    template: 'search/search'
    regions:
      searchFilters: '#search-filters'
      searchSummary: '#search-summary'
      searchResults: '#search-results'
