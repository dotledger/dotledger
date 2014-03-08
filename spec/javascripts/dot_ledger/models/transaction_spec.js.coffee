describe "DotLedger.Models.Transaction", ->
  it "should be defined", ->
    expect(DotLedger.Models.Transaction).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Models.Transaction::urlRoot).toEqual('/api/transaction')
