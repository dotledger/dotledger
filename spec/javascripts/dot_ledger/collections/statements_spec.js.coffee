describe "DotLedger.Collections.Statements", ->
  it "should be defined", ->
    expect(DotLedger.Collections.Statements).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Collections.Statements::url).toEqual('/api/statements')

  it "should use the correct model", ->
    expect(DotLedger.Collections.Statements::model).toEqual(DotLedger.Models.Statement)
