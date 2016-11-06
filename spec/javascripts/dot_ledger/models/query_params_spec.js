describe('DotLedger.Models.QueryParams', function () {
  it('should be defined', function () {
    expect(DotLedger.Models.QueryParams).toBeDefined();
  });

  describe('.toString', function () {
    it('returns a query string', function () {
      var model;
      model = new DotLedger.Models.QueryParams({
        foo: 'bar',
        bar: [42, 'baz']
      });

      expect(model.toString()).toEqual('foo=bar&bar=42&bar=baz');
    });
  });
});
