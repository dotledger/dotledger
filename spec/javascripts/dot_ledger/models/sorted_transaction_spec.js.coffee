describe "DotLedger.Models.SortedTransaction", ->
  it "should be defined", ->
    expect(DotLedger.Models.SortedTransaction).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Models.SortedTransaction::urlRoot).toEqual('/api/sorted_transactions')
