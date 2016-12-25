describe('DotLedger.Views.SavedSearches.List', function () {
  it('should be defined', function () {
    expect(DotLedger.Views.SavedSearches.List).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.SavedSearches.List).toUseTemplate('saved_searches/list');
  });
});
