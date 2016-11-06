describe('DotLedger.Models.SortingRule', function () {
  it('should be defined', function () {
    expect(DotLedger.Models.SortingRule).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Models.SortingRule.prototype.urlRoot).toEqual('/api/sorting_rules');
  });
});
