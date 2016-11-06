describe('DotLedger.Collections.Statements', function () {
  it('should be defined', function () {
    expect(DotLedger.Collections.Statements).toBeDefined();
  });

  it('should use the correct url', function () {
    expect(DotLedger.Collections.Statements.prototype.url).toEqual('/api/statements');
  });

  it('should use the correct model', function () {
    expect(DotLedger.Collections.Statements.prototype.model).toEqual(DotLedger.Models.Statement);
  });
});
