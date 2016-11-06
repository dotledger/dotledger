describe('DotLedger.Collections.ProjectedBalances', function () {
  it('should be defined', function () {
    expect(DotLedger.Collections.ProjectedBalances).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Collections.ProjectedBalances.prototype.url).toEqual('/api/balances/projected');
  });

  it('should use the correct model', function () {
    expect(DotLedger.Collections.ProjectedBalances.prototype.model).toEqual(DotLedger.Models.Balance);
  });
});
