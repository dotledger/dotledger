describe "DotLedger.Models.Statement", ->
  it "should be defined", ->
    expect(DotLedger.Models.Statement).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Models.Statement::urlRoot).toEqual('/api/statements')
