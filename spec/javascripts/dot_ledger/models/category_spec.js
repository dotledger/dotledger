describe('DotLedger.Models.Category', function () {
  it('should be defined', function () {
    expect(DotLedger.Models.Category).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Models.Category.prototype.urlRoot).toEqual('/api/categories');
  });
});
