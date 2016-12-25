describe('DotLedger.Collections.SavedSearches', function () {
  it('should be defined', function () {
    expect(DotLedger.Collections.SavedSearches).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Collections.SavedSearches.prototype.url).toEqual('/api/saved_searches');
  });

  it('should use the correct model', function () {
    expect(DotLedger.Collections.SavedSearches.prototype.model).toEqual(DotLedger.Models.SavedSearch);
  });
});
