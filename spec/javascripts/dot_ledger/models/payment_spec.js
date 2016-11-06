describe('DotLedger.Models.Payment', function () {
  it('should be defined', function () {
    expect(DotLedger.Models.Payment).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Models.Payment.prototype.urlRoot).toEqual('/api/payments');
  });
});
