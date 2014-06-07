describe "DotLedger.Models.Balance", ->
  it "should be defined", ->
    expect(DotLedger.Models.Balance).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Models.Balance::urlRoot).toEqual('/api/balances')
