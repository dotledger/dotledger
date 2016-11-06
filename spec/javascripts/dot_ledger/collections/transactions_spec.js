describe('DotLedger.Collections.Transactions', function () {
  it('should be defined', function () {
    expect(DotLedger.Collections.Transactions).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Collections.Transactions.prototype.url).toEqual('/api/transactions');
  });

  it('should use the correct model', function () {
    expect(DotLedger.Collections.Transactions.prototype.model).toEqual(DotLedger.Models.Transaction);
  });
});
