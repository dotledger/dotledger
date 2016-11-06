describe('DotLedger.Models.SortedTransaction', function () {
  it('should be defined', function () {
    expect(DotLedger.Models.SortedTransaction).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Models.SortedTransaction.prototype.urlRoot).toEqual('/api/sorted_transactions');
  });
});
