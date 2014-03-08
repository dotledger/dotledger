describe "DotLedger.Collections.SortingRules", ->
  it "should be defined", ->
    expect(DotLedger.Collections.SortingRules).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Collections.SortingRules::url).toEqual('/api/sorting_rules')

  it "should use the correct model", ->
    expect(DotLedger.Collections.SortingRules::model).toEqual(DotLedger.Models.SortingRule)
