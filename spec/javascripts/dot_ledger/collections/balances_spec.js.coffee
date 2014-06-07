describe "DotLedger.Collections.Balances", ->
  it "should be defined", ->
    expect(DotLedger.Collections.Balances).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Collections.Balances::url).toEqual('/api/balances')

  it "should use the correct model", ->
    expect(DotLedger.Collections.Balances::model).toEqual(DotLedger.Models.Balance)
