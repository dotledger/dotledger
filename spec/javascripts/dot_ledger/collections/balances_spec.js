describe('DotLedger.Collections.Balances', function () {
  it('should be defined', function () {
    expect(DotLedger.Collections.Balances).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Collections.Balances.prototype.url).toEqual('/api/balances');
  });

  it('should use the correct model', function () {
    expect(DotLedger.Collections.Balances.prototype.model).toEqual(DotLedger.Models.Balance);
  });
});
