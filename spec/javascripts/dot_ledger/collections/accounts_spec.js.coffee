describe "DotLedger.Collections.Accounts", ->
  it "should be defined", ->
    expect(DotLedger.Collections.Accounts).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Collections.Accounts::url).toEqual('/api/accounts')

  it "should use the correct model", ->
    expect(DotLedger.Collections.Accounts::model).toEqual(DotLedger.Models.Account)
