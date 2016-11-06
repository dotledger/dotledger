describe('DotLedger.Collections.Tags', function () {
  it('should be defined', function () {
    expect(DotLedger.Collections.Tags).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Collections.Tags.prototype.url).toEqual('/api/tags');
  });

  it('should use the correct model', function () {
    expect(DotLedger.Collections.Tags.prototype.model).toEqual(DotLedger.Models.Tag);
  });
});
