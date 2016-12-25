describe('DotLedger.Models.SavedSearch', function () {
  it('should be defined', function () {
    expect(DotLedger.Models.SavedSearch).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Models.SavedSearch.prototype.urlRoot).toEqual('/api/saved_searches');
  });
});
