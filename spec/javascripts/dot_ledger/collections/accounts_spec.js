describe('DotLedger.Collections.Accounts', function () {
  it('should be defined', function () {
    expect(DotLedger.Collections.Accounts).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Collections.Accounts.prototype.url).toEqual('/api/accounts');
  });

  it('should use the correct model', function () {
    expect(DotLedger.Collections.Accounts.prototype.model).toEqual(DotLedger.Models.Account);
  });
});
