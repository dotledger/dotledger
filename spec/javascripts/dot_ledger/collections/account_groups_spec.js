describe('DotLedger.Collections.AccountGroups', function () {
  it('should be defined', function () {
    expect(DotLedger.Collections.AccountGroups).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Collections.AccountGroups.prototype.url).toEqual('/api/account_groups');
  });

  it('should use the correct model', function () {
    expect(DotLedger.Collections.AccountGroups.prototype.model).toEqual(DotLedger.Models.AccountGroup);
  });
});
