describe('DotLedger.Collections.Payments', function () {
  it('should be defined', function () {
    expect(DotLedger.Collections.Payments).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Collections.Payments.prototype.url).toEqual('/api/payments');
  });

  it('should use the correct model', function () {
    expect(DotLedger.Collections.Payments.prototype.model).toEqual(DotLedger.Models.Payment);
  });
});
