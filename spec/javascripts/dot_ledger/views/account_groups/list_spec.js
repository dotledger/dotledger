describe('DotLedger.Views.AccountGroups.List', function () {
  it('should be defined', function () {
    expect(DotLedger.Views.AccountGroups.List).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.AccountGroups.List).toUseTemplate('account_groups/list');
  });
});
