describe "DotLedger.Collections.Transactions", ->
  it "should be defined", ->
    expect(DotLedger.Collections.Transactions).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Collections.Transactions::url).toEqual('/api/transactions')

  it "should use the correct model", ->
    expect(DotLedger.Collections.Transactions::model).toEqual(DotLedger.Models.Transaction)
