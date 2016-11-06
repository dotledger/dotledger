describe('DotLedger.Models.AccountGroup', function () {
  it('should be defined', function () {
    expect(DotLedger.Models.AccountGroup).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Models.AccountGroup.prototype.urlRoot).toEqual('/api/account_groups');
  });
});
