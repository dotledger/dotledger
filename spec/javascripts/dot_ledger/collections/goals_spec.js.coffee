describe "DotLedger.Collections.Goals", ->
  it "should be defined", ->
    expect(DotLedger.Collections.Goals).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Collections.Goals::url).toEqual('/api/goals')

  it "should use the correct model", ->
    expect(DotLedger.Collections.Goals::model).toEqual(DotLedger.Models.Goal)
