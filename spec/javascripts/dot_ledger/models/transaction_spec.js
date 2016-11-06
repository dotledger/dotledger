describe('DotLedger.Models.Transaction', function () {
  it('should be defined', function () {
    expect(DotLedger.Models.Transaction).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Models.Transaction.prototype.urlRoot).toEqual('/api/transaction');
  });
});
