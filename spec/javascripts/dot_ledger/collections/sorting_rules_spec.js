describe('DotLedger.Collections.SortingRules', function () {
  it('should be defined', function () {
    expect(DotLedger.Collections.SortingRules).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Collections.SortingRules.prototype.url).toEqual('/api/sorting_rules');
  });

  it('should use the correct model', function () {
    expect(DotLedger.Collections.SortingRules.prototype.model).toEqual(DotLedger.Models.SortingRule);
  });
});
