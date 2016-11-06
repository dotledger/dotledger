describe('DotLedger.Models.Goal', function () {
  it('should be defined', function () {
    expect(DotLedger.Models.Goal).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Models.Goal.prototype.urlRoot).toEqual('/api/goals');
  });
});
