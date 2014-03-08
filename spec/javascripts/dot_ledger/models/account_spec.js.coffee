describe "DotLedger.Models.Account", ->
  it "should be defined", ->
    expect(DotLedger.Models.Account).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Models.Account::urlRoot).toEqual('/api/accounts')
