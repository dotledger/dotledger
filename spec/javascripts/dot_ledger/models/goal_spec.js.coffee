describe "DotLedger.Models.Goal", ->
  it "should be defined", ->
    expect(DotLedger.Models.Goal).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Models.Goal::urlRoot).toEqual('/api/goals')
