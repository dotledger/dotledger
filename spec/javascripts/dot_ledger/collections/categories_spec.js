describe('DotLedger.Collections.Categories', function () {
  it('should be defined', function () {
    expect(DotLedger.Collections.Categories).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Collections.Categories.prototype.url).toEqual('/api/categories');
  });

  it('should use the correct model', function () {
    expect(DotLedger.Collections.Categories.prototype.model).toEqual(DotLedger.Models.Category);
  });
});
