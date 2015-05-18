describe "DotLedger.Helpers.Format", ->
  date = "2015-02-26T07:22:20.529"

  describe ".money", ->
    it "correctly formats a number to money", ->
      expect(DotLedger.Helpers.Format.money(123456.789)).toEqual('$123,456.79')
      expect(DotLedger.Helpers.Format.money(12.34)).toEqual('$12.34')
      expect(DotLedger.Helpers.Format.money(12)).toEqual('$12.00')

  describe ".pluralize", ->
    it "correctly formats 0", ->
      expect(DotLedger.Helpers.Format.pluralize(0, 'sausage', 'sausages')).toEqual('0 sausages')

    it "correctly formats 1", ->
      expect(DotLedger.Helpers.Format.pluralize(1, 'sausage', 'sausages')).toEqual('1 sausage')

    it "correctly formats 2", ->
      expect(DotLedger.Helpers.Format.pluralize(2, 'sausage', 'sausages')).toEqual('2 sausages')

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

  describe ".unixMilliTimestamp", ->
    it "correctly formats the date", ->
      # FIXME: I hate timezones.
      expect(DotLedger.Helpers.Format.unixMilliTimestamp(date)).toMatch(/^\d+$/)
