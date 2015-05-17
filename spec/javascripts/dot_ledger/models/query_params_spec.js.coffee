describe "DotLedger.Models.QueryParams", ->
  it "should be defined", ->
    expect(DotLedger.Models.QueryParams).toBeDefined()

  describe ".toString", ->
    it "returns a query string", ->
      model = new DotLedger.Models.QueryParams(foo: 'bar', bar: [42, 'baz'])

      expect(model.toString()).toEqual('foo=bar&bar=42&bar=baz')
