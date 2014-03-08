describe "DotLedger.Models.Category", ->
  it "should be defined", ->
    expect(DotLedger.Models.Category).toBeDefined()

  it "should use the correct url", ->
    expect(DotLedger.Models.Category::urlRoot).toEqual('/api/categories')
