describe('DotLedger.Views.Categories.List', function () {
  it('should be defined', function () {
    expect(DotLedger.Views.Categories.List).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.Categories.List).toUseTemplate('categories/list');
  });
});
