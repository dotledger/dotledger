describe "DotLedger.Collections.ProjectedBalances", ->
  it "should be defined", ->
    expect(DotLedger.Collections.ProjectedBalances).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Collections.ProjectedBalances::url).toEqual('/api/balances/projected')

  it "should use the correct model", ->
    expect(DotLedger.Collections.ProjectedBalances::model).toEqual(DotLedger.Models.Balance)
