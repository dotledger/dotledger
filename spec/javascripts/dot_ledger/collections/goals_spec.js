describe('DotLedger.Collections.Goals', function () {
  it('should be defined', function () {
    expect(DotLedger.Collections.Goals).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Collections.Goals.prototype.url).toEqual('/api/goals');
  });

  it('should use the correct model', function () {
    expect(DotLedger.Collections.Goals.prototype.model).toEqual(DotLedger.Models.Goal);
  });
});
