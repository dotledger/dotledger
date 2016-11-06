describe('DotLedger.Models.Balance', function () {
  it('should be defined', function () {
    expect(DotLedger.Models.Balance).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Models.Balance.prototype.urlRoot).toEqual('/api/balances');
  });
});
