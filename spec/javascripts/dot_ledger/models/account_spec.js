describe('DotLedger.Models.Account', function () {
  it('should be defined', function () {
    expect(DotLedger.Models.Account).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Models.Account.prototype.urlRoot).toEqual('/api/accounts');
  });
});
