describe "DotLedger.Models.SortingRule", ->
  it "should be defined", ->
    expect(DotLedger.Models.SortingRule).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Models.SortingRule::urlRoot).toEqual('/api/sorting_rules')
