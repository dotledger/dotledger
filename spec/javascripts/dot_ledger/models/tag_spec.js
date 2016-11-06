describe('DotLedger.Models.Tag', function () {
  it('should be defined', function () {
    expect(DotLedger.Models.Tag).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Models.Tag.prototype.urlRoot).toEqual('/api/tags');
  });
});
