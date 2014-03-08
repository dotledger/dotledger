describe "DotLedger.Models.Tag", ->
  it "should be defined", ->
    expect(DotLedger.Models.Tag).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Models.Tag::urlRoot).toEqual('/api/tags')
