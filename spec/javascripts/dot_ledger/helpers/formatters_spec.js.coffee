describe "DotLedger.Helpers.Format", ->
  date = "2015-02-26T07:22:20.529"

  describe ".money", ->
    it "correctly formats a number to money", ->
      expect(DotLedger.Helpers.Format.money(123456.789)).toEqual('$123,456.79')
      expect(DotLedger.Helpers.Format.money(12.34)).toEqual('$12.34')
      expect(DotLedger.Helpers.Format.money(12)).toEqual('$12.00')

  describe ".shortDateTime", ->
    it "correctly formats the date", ->
      expect(DotLedger.Helpers.Format.shortDateTime(date)).toEqual('26 Feb 2015 07:22:20')

  describe ".shortDate", ->
    it "correctly formats the date", ->
      expect(DotLedger.Helpers.Format.shortDate(date)).toEqual('26 Feb 2015')

  describe ".queryDate", ->
    it "correctly formats the date", ->
      expect(DotLedger.Helpers.Format.queryDate(date)).toEqual('2015-02-26')

  describe ".titleDate", ->
    it "correctly formats the date", ->
      expect(DotLedger.Helpers.Format.titleDate(date)).toEqual('February 26, 2015')

  describe ".unixTimestamp", ->
    it "correctly formats the date", ->
      # FIXME: I hate timezones.
      expect(DotLedger.Helpers.Format.unixTimestamp(date)).toMatch(/^\d+$/)
