describe "DotLedger.Helpers.Format", ->
  describe ".money", ->
    it "correctly formats a number to money", ->
      expect(DotLedger.Helpers.Format.money(123456.789)).toEqual('$123,456.79')
      expect(DotLedger.Helpers.Format.money(12.34)).toEqual('$12.34')
      expect(DotLedger.Helpers.Format.money(12)).toEqual('$12.00')
